class Comment < ApplicationRecord
  belongs_to :lyric
  belongs_to :user
  
  validates :content, presence: true, length: { maximum: 50 }
end
