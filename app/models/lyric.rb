class Lyric < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true, length: { maximum: 50 }
  #validates :content, presence: true
  validates :comment, presence: true, length: { maximum: 50 }
end
