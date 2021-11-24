class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[ show ]
  
  def show
    @user = User.find(params[:id])
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
