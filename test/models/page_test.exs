defmodule Habitus.PageTest do
  use Habitus.ModelCase

  alias Habitus.Page

  @valid_attrs %{alias: "some content", content: "some content", enable_comments: true, title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Page.changeset(%Page{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Page.changeset(%Page{}, @invalid_attrs)
    refute changeset.valid?
  end
end
