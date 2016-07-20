defmodule Habitus.Comment do
  use Habitus.Web, :model

  schema "comments" do
    field :content, :string
    belongs_to :user, Habitus.User
    belongs_to :page, Habitus.Page
    belongs_to :post, Habitus.Post

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:content, :user_id, :page_id])
    |> validate_required([:content])
  end
end


# defmodule Habitus.Comment do
#   use Habitus.Web, :model

#   schema "comments" do
#     field :content, :string
#     belongs_to :user, Habitus.User
#     belongs_to :page, Habitus.Page
#     #belongs_to :post, Habitus.Post

#     timestamps()
#   end

#   @doc """
#   Builds a changeset based on the `struct` and `params`.
#   """
#   def changeset(struct, params \\ %{}) do
#     struct
#     |> cast(params, [:content])
#     |> validate_required([:content])
#   end
# end
