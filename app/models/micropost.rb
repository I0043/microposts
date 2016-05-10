class Micropost < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, class_name: "user"
  
end