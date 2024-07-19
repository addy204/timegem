class CartsController < ApplicationController
  before_action :initialize_cart

  def show
  end

  def add
    product = Product.find(params[:product_id])
    item = @cart['items'].find { |i| i['product_id'] == product.id }
    if item
      item['quantity'] += 1
    else
      @cart['items'] << { 'product_id' => product.id, 'quantity' => 1 }
    end
    update_cart
    redirect_to cart_path, notice: 'Product added to cart.'
  end

  def update
    product = Product.find(params[:product_id])
    item = @cart['items'].find { |i| i['product_id'] == product.id }
    if item
      item['quantity'] = params[:quantity].to_i
      item['quantity'] = 1 if item['quantity'] < 1
    end
    update_cart
    redirect_to cart_path, notice: 'Cart updated.'
  end

  def remove
    product = Product.find(params[:product_id])
    @cart['items'].delete_if { |i| i['product_id'] == product.id }
    update_cart
    redirect_to cart_path, notice: 'Product removed from cart.'
  end

  private

  def initialize_cart
    @cart = session[:cart] ||= { 'items' => [] }
  end

  def update_cart
    session[:cart] = @cart
  end
end
