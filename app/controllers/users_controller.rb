class UsersController < ApplicationController

  # Add GET method to show user profile 
  def show
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through. 
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  # Set message sender
  def sender
     @user = User.find(params[:id])
  end

   # Set message recipient
  def recipient
    @user = User.find(params[:id])
  end

end
