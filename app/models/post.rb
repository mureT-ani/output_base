class Post < ApplicationRecord
  has_rich_text :post_text
  belongs_to :user
end
