defmodule Habitus.SettingController do
  use Habitus.Web, :controller

  alias Habitus.Setting
  alias JaSerializer.Params

  plug :scrub_params, "data" when action in [:create, :update]

  def index(conn, _params) do
    settings = Repo.all(Setting)
    render(conn, "index.json-api", data: settings)
  end

  def create(conn, %{"data" => data = %{"type" => "setting", "attributes" => _setting_params}}) do
    changeset = Setting.changeset(%Setting{}, Params.to_attributes(data))

    case Repo.insert(changeset) do
      {:ok, setting} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", setting_path(conn, :show, setting))
        |> render("show.json-api", data: setting)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Habitus.ChangesetView, "error.json-api", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    setting = Repo.get!(Setting, id)
    render(conn, "show.json-api", data: setting)
  end

  def update(conn, %{"id" => id, "data" => data = %{"type" => "setting", "attributes" => _setting_params}}) do
    setting = Repo.get!(Setting, id)
    changeset = Setting.changeset(setting, Params.to_attributes(data))

    case Repo.update(changeset) do
      {:ok, setting} ->
        render(conn, "show.json-api", data: setting)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Habitus.ChangesetView, "error.json-api", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    setting = Repo.get!(Setting, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(setting)

    send_resp(conn, :no_content, "")
  end

end
