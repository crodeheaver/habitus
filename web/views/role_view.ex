defmodule Habitus.RoleView do
  use Habitus.Web, :view
  use JaSerializer.PhoenixView

  attributes [:role_type, :inserted_at, :updated_at]
  

end
