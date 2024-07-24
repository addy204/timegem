# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  before_action :initialize_cart
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper OrdersHelper

  private

  def initialize_cart
    @cart = session[:cart] ||= { 'items' => [] }
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :address, :province_id])
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password, :password_confirmation, :current_password, :address, :province_id])
  end
end
