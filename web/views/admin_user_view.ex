defmodule Habitus.AdminUserView do
  use Habitus.Web, :view
  use JaSerializer.PhoenixView

  attributes [:display_name, :first_name, :last_name, :email, :inserted_at, :updated_at]
  
  has_one :role,
    serializer: Habitus.RoleView,
    type: "role"

end


# defmodule Habitus.UserView do
#   use Habitus.Web, :view
#   use JaSerializer.PhoenixView

#   attributes [:display_name, :first_name, :last_name, :email, :password_hash, :inserted_at, :updated_at]
  
#   has_one :role,
#     field: :role_id,
#     type: "role"

# end
