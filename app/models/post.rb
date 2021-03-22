class Post < ApplicationRecord
  has_rich_text :post_text
  belongs_to :user
  has_many :goods
  has_many :liked_users, through: :goods, source: :user
  has_many :comments

  validates :title, presence: true
  validate :post_text_required

  private

  def post_text_required
    errors.add(:post_text, 'is required') unless post_text.body.present?
  end
end
