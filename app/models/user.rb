class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :profile, presence: true, length: { maximum: 50 }
  validates :password, presence: true, length: { minimum: 8 }, on: :create
  mount_uploader :picture, PictureUploader
  
  has_many :lyrics
  has_many :messages
  has_many :comments
  
  has_many :talkrooms
  has_many :outgoing, through: :talkrooms, source: :roommate
  has_many :reverses_of_talkroom, class_name: 'Talkroom', foreign_key: 'roommate_id'
  has_many :incoming, through: :reverses_of_talkroom, source: :user
  
  has_many :favorites
  has_many :likes, through: :favorites, source: :lyric
  has_many :reverses_of_favorite, class_name: 'Favorite', foreign_key: 'lyric_id'
  has_many :liked, through: :reverses_of_favorite, source: :user
  
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship, source: :user
  
  def talk(roommate_user)
    unless self == roommate_user
      self.talkrooms.find_or_create_by(roommate_id: roommate_user.id)
    end
  end

  def untalk(roommate_user) 
    talkroom = self.talkrooms.find_by(roommate_id: roommate_user.id)
    talkroom.destroy if talkroom
  end

  def talking?(roommate_user)
    self.outgoing.include?(roommate_user)
  end
  
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  def like(lyric)
    self.favorites.find_or_create_by(lyric_id: lyric.id)
  end
  
  def unlike(lyric)
    favorite = self.favorites.find_or_create_by(lyric_id: lyric.id)
    favorite.destroy if favorite
  end

  def likes?(lyric)
    self.likes.include?(lyric)
  end
  
end
