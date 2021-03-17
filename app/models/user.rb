class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :job

  validates :email, uniqueness: true
  with_options presence: true do
       validates :nickname
       validates :job_id
       validates :birthday
  end
  validates :job_id, numericality: { other_than: 1 }
  end
