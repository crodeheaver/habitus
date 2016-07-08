defmodule Habitus.PostController do
  use Habitus.Web, :controller

  alias Habitus.Post
  alias JaSerializer.Params

  def index(conn, _params) do
    posts = Repo.all(Post)
    render(conn, "index.json", data: posts)
  end
  
  def show(conn, %{"id" => id}) do
    post = Repo.get!(Post, id)
    render(conn, "show.json", data: post)
  end

end
