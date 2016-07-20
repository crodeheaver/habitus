defmodule Habitus.Page do
  use Habitus.Web, :model

  schema "pages" do
    field :title, :string
    field :content, :string
    field :alias, :string
    field :enable_comments, :boolean, default: false
    has_many :comments, Habitus.Comment
    many_to_many :tags, Habitus.Tag, join_through: "posts_tags"

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :content, :alias, :enable_comments])
    |> validate_required([:title, :content, :alias, :enable_comments])
  end
end
