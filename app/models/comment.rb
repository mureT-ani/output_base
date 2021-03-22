class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :comment_text, presence: true, length: { maximum: 200 }
end
