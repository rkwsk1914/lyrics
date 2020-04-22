class RelationshipsController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    user = User.find(params[:follow_id])
    current_user.follow(user)
    flash[:success] = user.name + 'をフォローしました。/ Follow ' + user.name + '!'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    user = User.find(params[:follow_id])
    current_user.unfollow(user)
    flash[:secondary] = user.name + 'のフォローを解除しました。/ Cancel follow ' + user.name + '.'
    redirect_back(fallback_location: root_path)
  end

end
