defmodule Habitus.Tag do
  use Habitus.Web, :model

  schema "tags" do
    field :content, :string
    many_to_many :page, Habitus.Page, join_through: "posts_tags"

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:content])
    |> validate_required([:content])
  end
end
