defmodule Habitus.UserController do
  use Habitus.Web, :controller

  alias Habitus.User
  alias JaSerializer.Params
  
  plug :scrub_params, "data" when action in [:create, :update]

  def index(conn, _params) do
    #users = Repo.all(User)
    users = Repo.all from u in User, preload: [:role]
    render(conn, "index.json-api", data: users)
  end
  
  def show(conn, %{"id" => id}) do
    query = from u in User,
            preload: [:role]
    user = Repo.get_by!(query, id: id)# Repo.get!(query, id)
    render(conn, "show.json-api", data: user)
  end

end
