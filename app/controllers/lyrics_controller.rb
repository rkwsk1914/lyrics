class LyricsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @lyrics = Lyric.order(id: :desc).page(params[:page]).per(25)
  end
  
  def show
    @lyric = Lyric.find(params[:id])
  end
  
  def new
    @lyric = Lyric.new
  end
  
  def create
    @lyric = current_user.lyrics.build(lyrics_params)
    
    if @lyric.save
      flash[:success] = 'POST' + @lyric.title
      redirect_to @lyric
    else
      flash.now[:danger] = 'Fail POST !'
      render :new
    end 
  end
  
  def edit
    @lyric = Lyric.find(params[:id])
  end
  
  def update
    @lyric = Lyric.find(params[:id])
    
    if @lyric.update(lyrics_params)
      flash[:success] = 'Update Lyric'
      redirect_to @lyric
    else
      flash.now[:danger] = 'Fail to Update Lyric'
      render :edit
    end
  end
  
  def destroy
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
