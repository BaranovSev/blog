class User < ApplicationRecord
  has_many :microposts, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name,
  presence: true,
  length: { maximum: 50 }

  # def self_posts
  #   Micropost.where("user_id = ?", id)
  # end
end
