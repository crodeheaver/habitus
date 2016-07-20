defmodule Habitus.SavePageView do
  use Habitus.Web, :view
  use JaSerializer.PhoenixView

  attributes [:title, :content, :alias, :enable_comments, :inserted_at, :updated_at]
  
  has_many :comments,
    field: :page_id,
    type: "comment"
    
end

# defmodule Habitus.PageView do
#   use Habitus.Web, :view
#   use JaSerializer.PhoenixView

#   attributes [:title, :content, :alias, :inserted_at, :updated_at]

# end
