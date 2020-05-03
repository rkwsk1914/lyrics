class LyricsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @lyrics = Lyric.order(id: :desc).page(params[:page]).per(25)
    @user = User.find_by(id: session[:user_id])
    c_counts()
  end
  
  def show
    @lyric = Lyric.find(params[:id])
    @user = User.find(@lyric.user_id)
    c_counts()
  end
  
  def new
    @lyric = Lyric.new
  end
  
  def create
    @lyric = current_user.lyrics.build(lyrics_params)
    
    if @lyric.save
      flash[:success] = '『' + @lyric.title + '』を投稿しました。/　Post "' + @lyric.title + '"!!'
      redirect_to @lyric
    else
      flash.now[:danger] = 'Lyricの投稿に失敗しました。 / Fail POST!'
      render :new
    end 
  end
  
  def edit
    @lyric = Lyric.find(params[:id])
    @user = User.find(@lyric.user_id)
  end
  
  def update
    @lyric = Lyric.find(params[:id])
    
    if @lyric.update(lyrics_params)
      flash[:success] = '『' + @lyric.title + '』を更新しました。/ Update "' + @lyric.title + '"!'
      redirect_to @lyric
    else
      flash.now[:danger] = 'Lyricの更新に失敗しました。/Fail to Update Lyric!'
      render :edit
    end
  end
  
  def destroy
    @user = User.find(@lyric.user_id)
    if current_user.likes?(@lyric)
      current_user.unlike(@lyric)
    end
    @lyric.destroy
    flash[:success] = '『' + @lyric.title + '』を削除しました。/ Delete "' + @lyric.title + '".'
    redirect_to @user
  end
  
  private
  
  def lyrics_params
    params.require(:lyric).permit(:title, :content, :comment)
  end
  
  def correct_user
    @lyric = current_user.lyrics.find_by(id: params[:id])
    unless @lyric
      redirect_to lyric_path(params[:id])
    end
  end
end
