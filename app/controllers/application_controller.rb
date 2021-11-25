class ApplicationController < ActionController::Base
 
  # Default rails method to prevent cross-site request forgery
  protect_from_forgery with: :exception
  
  # Default and custom devise parameters
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Add pundit to application
  include Pundit

  # custom error for Pundit policy violations
  rescue_from Pundit::NotAuthorizedError, with: :forbidden


  protected

    def configure_permitted_parameters
      added_attrs = [:username, :phone_number, :first_name, :last_name]
      devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)
      devise_parameter_sanitizer.permit(:account_update, keys: added_attrs)
    end
  
  private

  # Create alert for unauthorised activities

  def forbidden
      flash[:alert] = "You are not authorised to perform that action!"
      redirect_to(request.referrer || root_path)
  end


end
