defmodule Habitus.PostView do
  use Habitus.Web, :view
  use JaSerializer.PhoenixView

  attributes [:title, :content, :alias, :enable_comments, :inserted_at, :updated_at]
    
    
  has_one :user,
    serializer: Habitus.UserView,
    include: true,
    type: "user"
    
  has_many :comments,
    serializer: Habitus.CommentView,
    include: true,
    type: "comment"
end

# defmodule Habitus.PostView do
#   use Habitus.Web, :view
#   use JaSerializer.PhoenixView

#   attributes [:title, :content, :inserted_at, :updated_at]
  
#   has_one :user,
#     field: :user_id,
#     type: "user"
    
#   has_many :comment,
#     field: :comments,
#     type: "comment"
    
#   has_many :tag,
#     field: :tags,
#     type: "tag"

# end
