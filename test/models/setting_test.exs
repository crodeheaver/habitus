defmodule Habitus.SettingTest do
  use Habitus.ModelCase

  alias Habitus.Setting

  @valid_attrs %{enable_blog: true, enable_file_uploads: true, enable_registration: true, enable_user_uploads: true, file_size_limit: 42, front_page: "some content", logo: "some content", tagline: "some content", theme: "some content", title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Setting.changeset(%Setting{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Setting.changeset(%Setting{}, @invalid_attrs)
    refute changeset.valid?
  end
end
