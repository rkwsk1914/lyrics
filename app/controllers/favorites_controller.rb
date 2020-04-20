class FavoritesController < ApplicationController
  before_action :require_user_logged_in

  def create
    lyric = Lyric.find(params[:lyric_id])
    current_user.favorites.find_or_create_by(lyric_id: lyric.id)
    flash[:success] = 'お気に入り登録しました。'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    lyric = Lyric.find(params[:lyric_id])
    current_user.unlike(lyric)
    flash[:success] = 'ユーザのフォローを解除しました。'
    redirect_back(fallback_location: root_path)
  end

end
