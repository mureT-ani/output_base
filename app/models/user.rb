class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :job

  has_many :posts
  has_many :goods
  has_many :liked_posts, through: :goods, source: :post

  validates :email, uniqueness: true
  with_options presence: true do
    validates :nickname
    validates :job_id
    validates :birthday
  end
  validates :job_id, numericality: { other_than: 1 }

  def already_liked?(post)
    goods.exists?(post_id: post.id)
  end
end
