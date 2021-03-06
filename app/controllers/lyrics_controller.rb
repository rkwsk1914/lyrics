class LyricsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :c_counts, only: [:index, :show, :edit, :new, :apply]
  
  def index
    @lyrics = Lyric.order(id: :desc).page(params[:page]).per(25)
    @user = User.find_by(id: session[:user_id])
  end
  
  def show
    @lyric = Lyric.find(params[:id])
    @user = User.find(@lyric.user_id)
    @comment = Comment.new
    @comments = @lyric.comments
    unless current_user.apply?(@lyric)
      @apply = current_user.requests.new
    else
      @apply = current_user.requests.find_by(lyric_id: @lyric.id)
    end
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
    @lyric.favorites.destroy_all
    @lyric.comments.destroy_all
    @lyric.requests.destroy_all
    
    @lyric.destroy
    flash[:success] = '『' + @lyric.title + '』を削除しました。/ Delete "' + @lyric.title + '".'
    redirect_to @user
  end
  
  def apply
    @lyric = Lyric.find(params[:id])
    @user = User.find(@lyric.user_id)
    unless @user == current_user
      redirect_back(fallback_location: root_path)
      return
    end
    @applys = @lyric.requests
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
