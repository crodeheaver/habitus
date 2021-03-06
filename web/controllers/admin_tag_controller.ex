defmodule Habitus.AdminTagController do
  use Habitus.Web, :controller

  alias Habitus.Tag
  alias JaSerializer.Params
  
  plug :scrub_params, "data" when action in [:create, :update]
  
  def create(conn, %{"data" => data = %{"type" => "tags", "attributes" => _tag_params}}) do
    changeset = Tag.changeset(%Tag{}, Params.to_attributes(data))

    case Repo.insert(changeset) do
      {:ok, tag} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", tag_path(conn, :show, tag))
        |> render("show.json-api", data: tag)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Habitus.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "data" => data = %{"type" => "tags", "attributes" => _tag_params}}) do
    tag = Repo.get!(Tag, id)
    changeset = Tag.changeset(tag, Params.to_attributes(data))

    case Repo.update(changeset) do
      {:ok, tag} ->
        render(conn, "show.json-api", data: tag)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Habitus.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    tag = Repo.get!(Tag, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(tag)

    send_resp(conn, :no_content, "")
  end

end
