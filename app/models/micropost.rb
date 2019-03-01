class Micropost < ApplicationRecord
  belongs_to :user
  
  validates :content, presence:true, length:{maximum: 255}
  
  has_many :favorites, dependent: :destroy
  has_many :done_favo_users, through: :favorites, source: :user 
  
  
end
