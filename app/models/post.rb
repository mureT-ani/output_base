class Post < ApplicationRecord
  has_rich_text :post_text
  belongs_to :user

  validate :post_text_required

  private

  def post_text_required
    errors.add(:post_text, 'is required') unless post_text.body.present?
  end
end
