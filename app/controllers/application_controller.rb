class ApplicationController < ActionController::Base

  # add phone number to user class/profile
  # Get rid of new listing in user profile
  # Create van class with parameters from add, including new parameter seating
  # Create van ammenities classes
  # Link profile to user listings
  # Add search functionality
 
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :forbidden



  protected

    def configure_permitted_parameters
      added_attrs = [:username, :phone_number, :first_name, :last_name]
      devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)
      devise_parameter_sanitizer.permit(:account_update, keys: added_attrs)
    end
  
  private

  def forbidden
      flash[:alert] = "You are not authorised to perform that action!"
      redirect_to(request.referrer || root_path)
  end


end
