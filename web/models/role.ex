defmodule Habitus.Role do
  use Habitus.Web, :model

  schema "roles" do
    field :role_type, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:role_type])
    |> validate_required([:role_type])
  end
end
