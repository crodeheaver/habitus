defmodule Habitus.TagController do
  use Habitus.Web, :controller

  alias Habitus.Tag
  alias JaSerializer.Params

  def index(conn, _params) do
    tags = Repo.all(Tag)
    render(conn, "index.json", data: tags)
  end

  def show(conn, %{"id" => id}) do
    tag = Repo.get!(Tag, id)
    render(conn, "show.json", data: tag)
  end

end
