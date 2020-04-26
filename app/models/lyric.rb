class Lyric < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 1024 }
  validates :comment, presence: true, length: { maximum: 50 }
  
  has_many :favorites
  has_many :likers, through: :favorites, source: :user
  has_many :reverses_of_favorite, class_name: 'Favorite', foreign_key: 'user_id'
  has_many :likes, through: :reverses_of_favorite, source: :lyric
  
end
