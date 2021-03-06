class UsersController < ApplicationController
  before_action :require_user_logged_in, except: [:new, :create]
  before_action :correct_user, only: [:edit, :update, :talkings]
  before_action :c_counts, only: [:show, :edit, :followers, :followings, :likes, :talkings]
  
  #def index
  #  @users = User.order(id: :desc).page(params[:page]).per(25)
  #end
  
  def show
    user_find()
    @lyrics = @user.lyrics.order(id: :desc) #.page(params[:page]).per(25)
    @current_user = current_user
    counts(@user)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'ようこそ' + @user.name + '! / Welcome ' + @user.name + ' !!'
      redirect_to login_path
    else
      flash.now[:danger] = 'ユーザー登録に失敗しました。/ Fail Sign Up !'
      render :new
    end 
  end
  
  def edit
    user_find()
  end
  
  def update
    user_find()
    
    if @user.update(user_params)
      flash[:success] = 'アカウント情報を更新しました。/ Updated account information.'
      redirect_to @user
    else
      flash.now[:danger] = 'アカウント情報の更新に失敗しました。 / Fail updated account information. !'
      render :edit
    end
  end
  
#  def destroy
#  end

  def origin
    @user = User.find_by(id: session[:user_id])
    ids = @user.followings.ids
    ids.push(@user.id)
    @lyrics = Lyric.all.where(user_id: ids).order(id: :desc).page(params[:page]).per(25)
    c_counts()  
  end

  def followings
    user_find()
    @followings = @user.followings.page(params[:page]).per(25)
    counts(@user)
  end
  
  def followers
    user_find()
    @followers = @user.followers.page(params[:page]).per(25)
    counts(@user)
  end
  
  def likes
    user_find()
    @lyrics = Lyric.joins(:favorites).where(favorites: {user_id: @user.id})
    counts(@user)
  end
  
  def talkings
    user_find()
    @talkrooms = Talkroom.all.where(user_id: current_user.id)
  end

  private
  
  def user_find
    @user = User.find(params[:id])
  end
  
  def user_params
    params.require(:user).permit(:name, :email, :profile, :password, :password_confirmation, :picture)
  end

  def correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(params[:id])
    end
  end
  
end
