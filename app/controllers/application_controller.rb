class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
	before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :phone
    devise_parameter_sanitizer.for(:account_update) << :phone
    devise_parameter_sanitizer.for(:sign_up) << :morning_commute
    devise_parameter_sanitizer.for(:account_update) << :morning_commute
    devise_parameter_sanitizer.for(:sign_up) << :evening_commute
    devise_parameter_sanitizer.for(:account_update) << :evening_commute
	end

end
