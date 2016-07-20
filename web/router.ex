defmodule Habitus.Router do
  use Habitus.Web, :router

  pipeline :api do
    plug :accepts, ["json","json-api"]
  end
  
  pipeline :auth do
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
    plug Guardian.Plug.EnsureAuthenticated, handler: Habitus.AuthErrorHandler
    plug JaSerializer.ContentTypeNegotiation
    plug JaSerializer.Deserializer
  end

  scope "/api/v1", Habitus do
    pipe_through :api
    post "/register", RegistrationController, :create
    post "/token", SessionController, :create, as: :login
    
    resources "/users", UserController, only: [:index, :show]
    resources "/posts", PostController, only: [:index, :show]
    resources "/pages", PageController, only: [:index, :show]
    resources "/comments", CommentController, only: [:index, :show]
    resources "/tags", TagController, only: [:index, :show]
    
    pipe_through :auth
    resources "/roles", RoleController, except: [:new, :edit]
    resources "/users", AdminUserController, only: [:create, :update, :delete]
    resources "/posts", AdminPostController, only: [:create, :update, :delete]
    resources "/pages", AdminPageController, only: [:create, :update, :delete]
    resources "/comments", AdminCommentController, only: [:create, :update, :delete]
    resources "/tags", AdminTagController, only: [:create, :update, :delete]
    resources "/settings", SettingController, except: [:new, :edit]
  end
end
