defmodule Habitus.User do
  use Habitus.Web, :model

  schema "users" do
    field :display_name, :string
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :password_hash, :string
    belongs_to :role, Habitus.Role
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  @required_fields ~w(display_name email password password_confirmation)
  @optional_fields ~w(first_name last_name)
  
  @required_fields_no_pass ~w()
  @optional_fields_no_pass ~w(display_name email first_name last_name)

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(data, params \\ %{}) do
    data
    |> cast(params, [:display_name, :email, :password, :password_confirmation, :role_id], @optional_fields)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 8)
    |> validate_confirmation(:password)
    |> unique_constraint(:email) 
    |> unique_constraint(:display_name) 
    |> hash_password
    
  end
  
  def changeset_no_pass(data, params \\ :empty) do
    data
    |> cast(params, @required_fields_no_pass, [:display_name, :first_name, :last_name, :email, :role_id])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email) 
    |> unique_constraint(:display_name) 
  end  
  
  def with_roles(query) do
    from u in query, preload: [roles: :role]
  end
  defp hash_password(%{valid?: false} = changeset), do: changeset
  defp hash_password(%{valid?: true} = changeset) do
      hashedpw = Comeonin.Bcrypt.hashpwsalt(Ecto.Changeset.get_field(changeset, :password))
      Ecto.Changeset.put_change(changeset, :password_hash, hashedpw)
  end
end


# defmodule Habitus.User do
#   use Habitus.Web, :model

#   schema "users" do
#     field :display_name, :string
#     field :first_name, :string
#     field :last_name, :string
#     field :email, :string
#     field :password_hash, :string
#     field :password, :string, virtual: true
#     field :password_confirmation, :string, virtual: true
    
#     belongs_to :role, Habitus.Role
#     timestamps()
#   end
  
#   @required_fields ~w(display_name email password password_confirmation)
#   @optional_fields ~w(first_name last_name)
  
#   @required_fields_no_pass ~w()
#   @optional_fields_no_pass ~w(display_name email first_name last_name)

#   @doc """
#   Builds a changeset based on the `struct` and `params`.
#   """
#   def changeset(data, params \\ %{}) do
#     data
#     |> cast(params, [:display_name, :email, :password, :password_confirmation, :role_id], @optional_fields)
#     |> validate_format(:email, ~r/@/)
#     |> validate_length(:password, min: 8)
#     |> validate_confirmation(:password)
#     |> hash_password
#     |> unique_constraint(:email) 
#     |> unique_constraint(:display_name) 
#   end
  
#   def changeset_no_pass(data, params \\ :empty) do
#     data
#     |> cast(params, @required_fields_no_pass, [:display_name, :first_name, :last_name, :email, :role_id])
#     |> validate_format(:email, ~r/@/)
#     |> unique_constraint(:email) 
#     |> unique_constraint(:display_name) 
#   end  
  
#   def with_roles(query) do
#     from u in query, preload: [roles: :role]
#   end
#   defp hash_password(%{valid?: false} = changeset), do: changeset
#   defp hash_password(%{valid?: true} = changeset) do
#       hashedpw = Comeonin.Bcrypt.hashpwsalt(Ecto.Changeset.get_field(changeset, :password))
#       Ecto.Changeset.put_change(changeset, :password_hash, hashedpw)
#   end
# end
