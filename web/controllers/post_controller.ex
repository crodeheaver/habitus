defmodule Habitus.PostController do
  use Habitus.Web, :controller

  alias Habitus.Post
  alias JaSerializer.Params

  plug :scrub_params, "data" when action in [:create, :update]

  def index(conn, _params) do
    #posts = Repo.all(Post)
    posts = Repo.all from p in Post,
             preload: [:user, :comments]
    render(conn, "index.json-api", data: posts)
  end

  def show(conn, %{"id" => id}) do
    #post = Repo.get!(Post, id)
    query = from p in Post,
            preload: [:user, :comments]
    post = Repo.get_by!(query, id: id)
    render(conn, "show.json-api", data: post)
  end

end


# defmodule Habitus.PostController do
#   use Habitus.Web, :controller

#   alias Habitus.Post
#   alias JaSerializer.Params

#   def index(conn, _params) do
#     posts = Repo.all(Post)
#     render(conn, "index.json-api", data: posts)
#   end
  
#   def show(conn, %{"id" => id}) do
#     post = Repo.get!(Post, id)
#     render(conn, "show.json-api", data: post)
#   end

# end
