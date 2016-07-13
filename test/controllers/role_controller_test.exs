defmodule Habitus.RoleControllerTest do
  use Habitus.ConnCase

  alias Habitus.Role
  alias Habitus.Repo

  @valid_attrs %{role_type: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
      |> put_req_header("accept", "application/vnd.api+json")
      |> put_req_header("content-type", "application/vnd.api+json")

    {:ok, conn: conn}
  end
  
  defp relationships do
    %{}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, role_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    role = Repo.insert! %Role{}
    conn = get conn, role_path(conn, :show, role)
    data = json_response(conn, 200)["data"]
    assert data["id"] == "#{role.id}"
    assert data["type"] == "role"
    assert data["attributes"]["role_type"] == role.role_type
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, role_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, role_path(conn, :create), %{
      "meta" => %{},
      "data" => %{
        "type" => "role",
        "attributes" => @valid_attrs,
        "relationships" => relationships
      }
    }

    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Role, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, role_path(conn, :create), %{
      "meta" => %{},
      "data" => %{
        "type" => "role",
        "attributes" => @invalid_attrs,
        "relationships" => relationships
      }
    }

    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    role = Repo.insert! %Role{}
    conn = put conn, role_path(conn, :update, role), %{
      "meta" => %{},
      "data" => %{
        "type" => "role",
        "id" => role.id,
        "attributes" => @valid_attrs,
        "relationships" => relationships
      }
    }

    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Role, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    role = Repo.insert! %Role{}
    conn = put conn, role_path(conn, :update, role), %{
      "meta" => %{},
      "data" => %{
        "type" => "role",
        "id" => role.id,
        "attributes" => @invalid_attrs,
        "relationships" => relationships
      }
    }

    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    role = Repo.insert! %Role{}
    conn = delete conn, role_path(conn, :delete, role)
    assert response(conn, 204)
    refute Repo.get(Role, role.id)
  end

end
