class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:session][:email].downcase
    password = params[:session][:password]
    user = User.find_by(email: email)
    if login(email, password)
      flash[:success] = 'ログインに成功しました。/ Welcome back' + user.name + ' !!'
      redirect_to lyrics_path
    else
      flash.now[:danger] = 'EmailまたはPasswordが不正です。/ Incorrect Email or Password!!'
      render :new
    end
  end

  def destroy
    user = User.find(session[:user_id])
    session[:user_id] = nil
    flash[:success] = 'ログアウトしました。/ See you ' + user.name + '!'
    redirect_to root_url
  end
  
  private
  
  def login(email,password)
    @user = User.find_by(email: email)
    if @user && @user.authenticate(password)
      session[:user_id] = @user.id
      return true
    else
      return false
    end
  end
  
end
