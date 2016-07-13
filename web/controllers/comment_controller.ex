defmodule Habitus.CommentController do
  use Habitus.Web, :controller

  alias Habitus.Comment
  alias JaSerializer.Params

  def index(conn, _params) do
    comments = Repo.all(Comment)
    render(conn, "index.json-api", data: comments)
  end

  def show(conn, %{"id" => id}) do
    comment = Repo.get!(Comment, id)
    render(conn, "show.json-api", data: comment)
  end

end
