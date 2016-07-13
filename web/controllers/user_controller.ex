defmodule Habitus.UserController do
  use Habitus.Web, :controller

  alias Habitus.User
  alias JaSerializer.Params
  
  plug Guardian.Plug.EnsureAuthenticated, handler: Habitus.AuthErrorHandler
  plug :scrub_params, "data" when action in [:create, :update]

  def index(conn, _params) do
    #users = Repo.all(User)
    users = Repo.all from u in User,
             preload: [:role]
    render(conn, "index.json-api", data: users)
  end

  def create(conn, %{"data" => data = %{"type" => "users", "attributes" => _user_params}}) do
    changeset = User.changeset(%User{}, Params.to_attributes(data))

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", user_path(conn, :show, user))
        |> render(Habitus.UserSaveView, "show.json-api", data: user)
        #|> render("show.json-api", data: user)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Habitus.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
  query = from u in User,
            preload: [:role]
    user = Repo.get!(query, id)
    render(conn, "show.json-api", data: user)
  end

  def update(conn, %{"id" => id, "data" => data = %{"type" => "users", "attributes" => _user_params}}) do
    query = from u in User,
            preload: [:role]
    user = Repo.get!(query, id)
    # user = Repo.get!(User, id)
    # changeset = User.changeset(user, Params.to_attributes(data))
     cond do 
       is_nil _user_params["password"] -> 
         changeset = User.changeset_no_pass(user, Params.to_attributes(data))
       true ->
           changeset = User.changeset(user, Params.to_attributes(data))
       end
    

    case Repo.update(changeset) do
      {:ok, user} ->
        render(conn, "show.json-api", data: user)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Habitus.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Repo.get!(User, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(user)

    send_resp(conn, :no_content, "")
  end

end


# defmodule Habitus.UserController do
#   use Habitus.Web, :controller

#   alias Habitus.User
#   alias JaSerializer.Params
  
#   plug Guardian.Plug.EnsureAuthenticated, handler: Habitus.AuthErrorHandler
#   plug :scrub_params, "data" when action in [:create, :update]

#   def index(conn, _params) do
#     #users = Repo.all(User)
#     users = Repo.all from u in User,
#             preload: [:role]
#     IO.inspect users
#     render(conn, "index.json", data: users)
#   end

#   def create(conn, %{"data" => data = %{"type" => "users", "attributes" => _user_params}}) do
#     changeset = User.changeset(%User{}, Params.to_attributes(data))

#     case Repo.insert(changeset) do
#       {:ok, user} ->
#         conn
#         |> put_status(:created)
#         |> put_resp_header("location", user_path(conn, :show, user))
#         |> render("show.json", data: user)
#       {:error, changeset} ->
#         conn
#         |> put_status(:unprocessable_entity)
#         |> render(Habitus.ChangesetView, "error.json", changeset: changeset)
#     end
#   end

#   def show(conn, %{"id" => id}) do
#     user = Repo.get!(User, id)
#     render(conn, "show.json", data: user)
#   end

#   def update(conn, %{"id" => id, "data" => data = %{"type" => "users", "attributes" => _user_params}}) do
#     user = Repo.get!(User, id)
#     #IO.inspect _user_params
#     cond do 
#       is_nil _user_params["password"] -> 
#         changeset = User.changeset_no_pass(user, Params.to_attributes(data))
#       true ->
#           changeset = User.changeset(user, Params.to_attributes(data))
#       end
        

#     case Repo.update(changeset) do
#       {:ok, user} ->
#         render(conn, "show.json", data: user)
#       {:error, changeset} ->
#         conn
#         |> put_status(:unprocessable_entity)
#         |> render(Habitus.ChangesetView, "error.json", changeset: changeset)
#     end
#   end

#   def delete(conn, %{"id" => id}) do
#     user = Repo.get!(User, id)

#     # Here we use delete! (with a bang) because we expect
#     # it to always work (and if it does not, it will raise).
#     Repo.delete!(user)

#     send_resp(conn, :no_content, "")
#   end

# end
