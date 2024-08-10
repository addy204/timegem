class ApplicationController < ActionController::Base
  include ApplicationHelper # Makes helper methods available in controllers

  before_action :initialize_cart
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :add_home_breadcrumb # Always add the home breadcrumb

  private

  def initialize_cart
    @cart = session[:cart] ||= { 'items' => [] }
  end

  def add_home_breadcrumb
    add_breadcrumb "Home", :root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :address, :province_id])
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password, :password_confirmation, :current_password, :address, :province_id])
  end
end
