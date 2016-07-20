defmodule Habitus.CommentControllerTest do
  use Habitus.ConnCase

  alias Habitus.Comment
  alias Habitus.Repo

  @valid_attrs %{content: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
      |> put_req_header("accept", "application/vnd.api+json")
      |> put_req_header("content-type", "application/vnd.api+json")

    {:ok, conn: conn}
  end
  
  defp relationships do 
    user = Repo.insert!(%Habitus.User{})
    page = Repo.insert!(%Habitus.Page{})
    post = Repo.insert!(%Habitus.Post{})

    %{
      "user" => %{
        "data" => %{
          "type" => "user",
          "id" => user.id
        }
      },
      "page" => %{
        "data" => %{
          "type" => "page",
          "id" => page.id
        }
      },
      "post" => %{
        "data" => %{
          "type" => "post",
          "id" => post.id
        }
      },
    }
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, comment_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    comment = Repo.insert! %Comment{}
    conn = get conn, comment_path(conn, :show, comment)
    data = json_response(conn, 200)["data"]
    assert data["id"] == "#{comment.id}"
    assert data["type"] == "comment"
    assert data["attributes"]["content"] == comment.content
    assert data["attributes"]["user_id"] == comment.user_id
    assert data["attributes"]["page_id"] == comment.page_id
    assert data["attributes"]["post_id"] == comment.post_id
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, comment_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, comment_path(conn, :create), %{
      "meta" => %{},
      "data" => %{
        "type" => "comment",
        "attributes" => @valid_attrs,
        "relationships" => relationships
      }
    }

    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Comment, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, comment_path(conn, :create), %{
      "meta" => %{},
      "data" => %{
        "type" => "comment",
        "attributes" => @invalid_attrs,
        "relationships" => relationships
      }
    }

    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    comment = Repo.insert! %Comment{}
    conn = put conn, comment_path(conn, :update, comment), %{
      "meta" => %{},
      "data" => %{
        "type" => "comment",
        "id" => comment.id,
        "attributes" => @valid_attrs,
        "relationships" => relationships
      }
    }

    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Comment, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    comment = Repo.insert! %Comment{}
    conn = put conn, comment_path(conn, :update, comment), %{
      "meta" => %{},
      "data" => %{
        "type" => "comment",
        "id" => comment.id,
        "attributes" => @invalid_attrs,
        "relationships" => relationships
      }
    }

    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    comment = Repo.insert! %Comment{}
    conn = delete conn, comment_path(conn, :delete, comment)
    assert response(conn, 204)
    refute Repo.get(Comment, comment.id)
  end

end
