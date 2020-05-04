class Talkroom < ApplicationRecord
  belongs_to :user
  belongs_to :roommate, class_name: 'User'
  
  has_many :messages
end
