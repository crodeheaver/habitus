defmodule Habitus.SettingView do
  use Habitus.Web, :view
  use JaSerializer.PhoenixView

  attributes [:title, :tagline, :logo, :theme, :file_size_limit, :enable_user_uploads, :enable_registration, :enable_blog, :enable_file_uploads, :front_page, :inserted_at, :updated_at]
  

end
