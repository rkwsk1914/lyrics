class Request < ApplicationRecord
  belongs_to :user
  belongs_to :lyric
  
  validates :comments, presence: true, length: { maximum: 200 }
  
  #mount_uploader :musicdata , AudioFileUploader
  #validates :musicdata, presence: true
end
