class UsersController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def index
    @users = User.order(id: :desc).page(params[:page]).per(25)
  end
  
  def show
    @user = User.find(params[:id])
    @lyrics = @user.lyrics.order(id: :desc).page(params[:page]).per(25)
    counts(@user)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'Welcome!!' + @user.name
      redirect_to lyrics_path
    else
      flash.now[:danger] = 'Fail Sign Up !'
      render :new
    end 
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    
    if @user.update(user_params)
      flash[:success] = 'Renew Profile'
      redirect_to @user
    else
      flash.now[:danger] = 'Fail Sign Up !'
      render :edit
    end
  end
  
  def destroy
  end

  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page]).per(25)
    counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page]).per(25)
    counts(@user)
  end
  
  def likes
    @user = User.find(params[:id])
    @likes = @user.favorites.page(params[:page]).per(25)
    counts(@user)
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :profile, :password, :password_confirmation)
  end

  def correct_user
    unless @user == current_user
      redirect_to user_path(params[:id])
    end
  end
end
