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
    session[:cart] = @cart
    redirect_to cart_path
  end

  def update
    product = Product.find(params[:product_id])
    item = @cart['items'].find { |i| i['product_id'] == product.id }
    if item
      item['quantity'] = params[:quantity].to_i
      session[:cart] = @cart
    end
    redirect_to cart_path
  end

  def remove
    product = Product.find(params[:product_id])
    @cart['items'].reject! { |i| i['product_id'] == product.id }
    session[:cart] = @cart
    redirect_to cart_path
  end
end
