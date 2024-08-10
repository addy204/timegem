# frozen_string_literal: true

class CartsController < ApplicationController
  def add
    product_id = params[:product_id]
    quantity = params[:quantity].to_i

    # Initialize the cart if it's not already
    session[:cart] ||= {}
    session[:cart][product_id] ||= 0
    session[:cart][product_id] += quantity

    redirect_to cart_path, notice: 'Product added to cart'
  end

  def update
    product_id = params[:product_id]
    quantity = params[:quantity].to_i

    # Update the product quantity in the cart
    session[:cart][product_id] = quantity

    redirect_to cart_path, notice: 'Cart updated'
  end

  def remove
    product_id = params[:product_id]

    # Remove the product from the cart
    session[:cart].delete(product_id)

    redirect_to cart_path, notice: 'Product removed from cart'
  end

  def show
    @cart = session[:cart] || {}
    @cart_items = @cart.map do |product_id, quantity|
      product = Product.find(product_id)
      { product:, quantity: }
    end
  end
end
