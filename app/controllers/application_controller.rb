class ApplicationController < ActionController::Base
  before_action :initialize_cart
  helper OrdersHelper

  private

  def initialize_cart
    @cart = session[:cart] ||= { 'items' => [] }
  end
end
