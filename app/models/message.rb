class Message < ApplicationRecord
  belongs_to :talkroom
  
  validates :content, presence: true
end
