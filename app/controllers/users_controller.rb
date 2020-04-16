class UsersController < ApplicationController
  
  def index
    @users = User.order(id: :desc).page(params[:page]).per(25)
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'Welcome!!' + @user.name
      redirect_to @user
    else
      flash.now[:danger] = 'Fail Sign Up !'
      render :new
    end 
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
