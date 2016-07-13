defmodule Habitus.PageController do
  use Habitus.Web, :controller

  alias Habitus.Page
  alias JaSerializer.Params
  plug :scrub_params, "data" when action in [:create, :update]

  def index(conn, _params) do
    pages = Repo.all(Page)
    render(conn, "index.json-api", data: pages)
  end

  def show(conn, %{"id" => id}) do
    page = Repo.get_by!(Page, alias: id)
    render(conn, "show.json-api", data: page)
  end

end