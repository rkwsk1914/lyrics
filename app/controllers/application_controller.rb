class ApplicationController < ActionController::Base
  include SessionsHelper
  include TalkroomsHelper
  include CommentsHelper
  
  private

  def require_user_logged_in
    unless logged_in?
      redirect_to :root
    end
  end

  def counts(user)
    @count_lyrics = user.lyrics.count
    @count_followings = user.followings.count
    @count_followers = user.followers.count
    @count_likes = user.favorites.count
  end

  def c_counts
    @c_count_lyrics = current_user.lyrics.count
    @c_count_followings = current_user.followings.count
    @c_count_followers = current_user.followers.count
    @c_count_likes = current_user.favorites.count
    @receiveroom = Talkroom.where(roommate_id: current_user.id)
    @count_unread = counts_unread(@receiveroom)
  end
end
