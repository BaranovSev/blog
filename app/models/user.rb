class User < ApplicationRecord
  has_many :microposts, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
                                  foreign_key: "followed_id",
                                  dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed # using source to rename(:followeds -> :followed)
  has_many :followers, through: :passive_relationships, source: :follower # using to find count of subscribers
  
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
  
  def feed
    Micropost.where("user_id IN (:following_ids) OR user_id = :user_id",
    following_ids: following_ids, user_id: id)
  end
  
  # Follows a user.
  def follow(other_user)
    following << other_user
  end
  
  # Unfollows a user.
  def unfollow(other_user)
    following.delete(other_user)
  end
  
  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end
end
