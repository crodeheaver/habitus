defmodule Habitus.RoleTest do
  use Habitus.ModelCase

  alias Habitus.Role

  @valid_attrs %{role_type: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Role.changeset(%Role{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Role.changeset(%Role{}, @invalid_attrs)
    refute changeset.valid?
  end
end
