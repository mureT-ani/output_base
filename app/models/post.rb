class Post < ApplicationRecord
  has_rich_text :post_text
  belongs_to :user
  has_many :goods, dependent: :destroy
  has_many :liked_users, through: :goods, source: :user
  has_many :comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  validates :title, presence: true
  validate :post_text_required

  def save_posts(tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - tags
    new_tags = tags - current_tags

    # Destroy
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name: old_name)
    end

    # Create
    new_tags.each do |new_name|
      post_tag = Tag.find_or_create_by(name: new_name)
      self.tags << post_tag
    end
  end

  private

  def post_text_required
    errors.add(:post_text, 'is required') unless post_text.body.present?
  end
end
