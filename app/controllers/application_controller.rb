class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me, :name, :avatar, :address, :postcode, :city, :tel, :website, :facebook, :twitter, :remote_avatar_url, :role) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password, :name, :avatar, :address, :postcode, :city, :tel, :website, :facebook, :twitter, :remote_avatar_url, :role) }
    devise_parameter_sanitizer.for(:sing_in) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password, :name, :avatar, :address, :postcode, :city, :tel, :website, :facebook, :twitter, :remote_avatar_url, :role) }
  end

end
