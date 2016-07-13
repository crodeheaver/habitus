defmodule Habitus.RoleController do
  use Habitus.Web, :controller

  alias Habitus.Role
  alias JaSerializer.Params

  plug :scrub_params, "data" when action in [:create, :update]

  def index(conn, _params) do
    roles = Repo.all(Role)
    render(conn, "index.json-api", data: roles)
  end

  def create(conn, %{"data" => data = %{"type" => "role", "attributes" => _role_params}}) do
    changeset = Role.changeset(%Role{}, Params.to_attributes(data))

    case Repo.insert(changeset) do
      {:ok, role} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", role_path(conn, :show, role))
        |> render("show.json-api", data: role)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Habitus.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    role = Repo.get!(Role, id)
    render(conn, "show.json-api", data: role)
  end

  def update(conn, %{"id" => id, "data" => data = %{"type" => "role", "attributes" => _role_params}}) do
    role = Repo.get!(Role, id)
    changeset = Role.changeset(role, Params.to_attributes(data))

    case Repo.update(changeset) do
      {:ok, role} ->
        render(conn, "show.json-api", data: role)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Habitus.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    role = Repo.get!(Role, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(role)

    send_resp(conn, :no_content, "")
  end

end
