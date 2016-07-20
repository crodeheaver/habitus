defmodule Habitus.Post do
  use Habitus.Web, :model

  schema "posts" do
    field :title, :string
    field :content, :string
    field :alias, :string
    field :enable_comments, :boolean, default: false
    belongs_to :user, Habitus.User
    has_many :comments, Habitus.Comment
    #has_many :tags, Habitus.Tag

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :content, :alias, :enable_comments, :user_id])
    |> validate_required([:title, :content, :alias, :enable_comments, :user_id])
  end
end

# defmodule Habitus.Post do
#   use Habitus.Web, :model

#   schema "posts" do
#     field :title, :string
#     field :content, :string
#     belongs_to :user, Habitus.User
#     has_many :comments, Habitus.Comment
#     has_many :tags, Habitus.Tag

#     timestamps()
#   end

#   @doc """
#   Builds a changeset based on the `struct` and `params`.
#   """
#   def changeset(struct, params \\ %{}) do
#     struct
#     |> cast(params, [:title, :content])
#     |> validate_required([:title, :content])
#   end
# end
