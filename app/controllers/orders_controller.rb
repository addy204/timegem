class OrdersController < ApplicationController
  before_action :initialize_cart, only: [:new, :create]

  def new
    @order = Order.new
    @order.build_customer
  end

  def create
    @customer = Customer.find_or_initialize_by(email: order_params[:customer][:email]) do |customer|
      customer.name = order_params[:customer][:name]
    end

    if @customer.save
      @address = @customer.addresses.create(order_params[:address])

      @order = @customer.orders.create(status: "pending", total: calculate_total)
      @cart['items'].each do |item|
        product = Product.find(item['product_id'])
        @order.order_items.create(
          product: product,
          quantity: item['quantity'],
          price: product.price
        )
      end

      if @order.save
        session.delete(:cart)
        redirect_to @order, notice: "Order was successfully created."
      else
        flash[:alert] = "Order creation failed."
        render :new
      end
    else
      flash[:alert] = "Invalid customer details."
      render :new
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(
      customer: [:name, :email],
      address: [:address_line_1, :address_line_2, :city, :province, :postal_code, :country]
    )
  end

  def calculate_total
    subtotal = @cart['items'].sum do |item|
      product = Product.find(item['product_id'])
      product.price * item['quantity']
    end

    province = order_params[:address][:province]
    gst = 0.05 # 5% GST
    pst = 0.07 # 7% PST
    hst = 0.13 # 13% HST

    taxes = case province
            when 'Ontario'
              subtotal * hst
            when 'British Columbia'
              subtotal * (gst + pst)
            else
              subtotal * gst
            end

    subtotal + taxes
  end
end
