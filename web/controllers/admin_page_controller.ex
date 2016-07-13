defmodule Habitus.AdminPageController do
  use Habitus.Web, :controller

  alias Habitus.Page
  alias JaSerializer.Params
  import Logger
  plug :scrub_params, "data" when action in [:create, :update]

  def create(conn, %{"data" => data = %{"type" => "pages", "attributes" => _page_params}}) do
    changeset = Page.changeset(%Page{}, Params.to_attributes(data))
    current_user = Guardian.Plug.current_resource(conn)
    IO.inspect current_user
    case Repo.insert(changeset) do
      {:ok, page} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", page_path(conn, :show, page))
        |> render("show.json-api", data: page)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Habitus.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "data" => data = %{"type" => "pages", "attributes" => _page_params}}) do
    page = Repo.get!(Page, id)
    changeset = Page.changeset(page, Params.to_attributes(data))

    case Repo.update(changeset) do
      {:ok, page} ->
        render(conn, "show.json-api", data: page)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Habitus.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    page = Repo.get!(Page, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(page)

    send_resp(conn, :no_content, "")
  end

end