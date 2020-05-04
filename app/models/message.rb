class Message < ApplicationRecord
  belongs_to :talkroom
  
  validates :content, presence: true, length: { maximum: 255 }
end
