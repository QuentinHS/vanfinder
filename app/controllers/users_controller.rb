class UsersController < ApplicationController

  def show
    @user = User.friendly.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  def sender
     @user = User.find(params[:id])
  end

  def recipient
    @user = User.find(params[:id])
  end

end
