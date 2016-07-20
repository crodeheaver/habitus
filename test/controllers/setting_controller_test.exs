defmodule Habitus.SettingControllerTest do
  use Habitus.ConnCase

  alias Habitus.Setting
  alias Habitus.Repo

  @valid_attrs %{enable_blog: true, enable_file_uploads: true, enable_registration: true, enable_user_uploads: true, file_size_limit: 42, front_page: "some content", logo: "some content", tagline: "some content", theme: "some content", title: "some content"}
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
    conn = get conn, setting_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    setting = Repo.insert! %Setting{}
    conn = get conn, setting_path(conn, :show, setting)
    data = json_response(conn, 200)["data"]
    assert data["id"] == "#{setting.id}"
    assert data["type"] == "setting"
    assert data["attributes"]["title"] == setting.title
    assert data["attributes"]["tagline"] == setting.tagline
    assert data["attributes"]["logo"] == setting.logo
    assert data["attributes"]["theme"] == setting.theme
    assert data["attributes"]["file_size_limit"] == setting.file_size_limit
    assert data["attributes"]["enable_user_uploads"] == setting.enable_user_uploads
    assert data["attributes"]["enable_registration"] == setting.enable_registration
    assert data["attributes"]["enable_blog"] == setting.enable_blog
    assert data["attributes"]["enable_file_uploads"] == setting.enable_file_uploads
    assert data["attributes"]["front_page"] == setting.front_page
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, setting_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, setting_path(conn, :create), %{
      "meta" => %{},
      "data" => %{
        "type" => "setting",
        "attributes" => @valid_attrs,
        "relationships" => relationships
      }
    }

    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Setting, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, setting_path(conn, :create), %{
      "meta" => %{},
      "data" => %{
        "type" => "setting",
        "attributes" => @invalid_attrs,
        "relationships" => relationships
      }
    }

    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    setting = Repo.insert! %Setting{}
    conn = put conn, setting_path(conn, :update, setting), %{
      "meta" => %{},
      "data" => %{
        "type" => "setting",
        "id" => setting.id,
        "attributes" => @valid_attrs,
        "relationships" => relationships
      }
    }

    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Setting, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    setting = Repo.insert! %Setting{}
    conn = put conn, setting_path(conn, :update, setting), %{
      "meta" => %{},
      "data" => %{
        "type" => "setting",
        "id" => setting.id,
        "attributes" => @invalid_attrs,
        "relationships" => relationships
      }
    }

    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    setting = Repo.insert! %Setting{}
    conn = delete conn, setting_path(conn, :delete, setting)
    assert response(conn, 204)
    refute Repo.get(Setting, setting.id)
  end

end
