class SessionsController < ApplicationController

  skip_before_action :ensure_login, only: [:new, :create]

  def new
  end

  def create
    @user = User.find_by(username: user_params[:username]) || DummyUser.new
    if @user.authenticate(user_params[:password])
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Logged in successfully"
    else
      redirect_to login_path, alert: "Invalid username or password"
    end
  end

  def destroy
    session.clear
    redirect_to login_path, notice: "Logged out successfully"
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end

  class DummyUser
    def authenticate(password)
      false
    end
  end
end
