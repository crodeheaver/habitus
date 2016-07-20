defmodule Habitus.Setting do
  use Habitus.Web, :model

  schema "settings" do
    field :title, :string
    field :tagline, :string
    field :logo, :string
    field :theme, :string
    field :file_size_limit, :integer
    field :enable_user_uploads, :boolean, default: false
    field :enable_registration, :boolean, default: false
    field :enable_blog, :boolean, default: false
    field :enable_file_uploads, :boolean, default: false
    field :front_page, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :tagline, :logo, :theme, :file_size_limit, :enable_user_uploads, :enable_registration, :enable_blog, :enable_file_uploads, :front_page])
    |> validate_required([:title, :tagline, :logo, :theme, :file_size_limit, :enable_user_uploads, :enable_registration, :enable_blog, :enable_file_uploads, :front_page])
  end
end
