class OrdersController < ApplicationController
  before_action :initialize_cart, only: [:new, :create]
  before_action :authenticate_user!

  def new
    @order = current_user.orders.build
    @order.build_customer unless current_user.customer
    if @order.customer.nil?
      @order.build_customer
    end
    @order.customer.addresses.build if @order.customer.addresses.empty?
  end

  def create
    @order = current_user.orders.build(order_params)
    @order.customer = current_user.customer || current_user.build_customer(order_params[:customer_attributes])
    @order.status = "pending"
    @order.total = calculate_total

    if @order.save
      @cart['items'].each do |item|
        product = Product.find(item['product_id'])
        @order.order_items.create(
          product: product,
          quantity: item['quantity'],
          price: product.price
        )
      end
      session.delete(:cart)
      redirect_to @order, notice: "Order was successfully created."
    else
      @order.customer.addresses.build unless @order.customer.addresses.any?
      flash[:alert] = "Order creation failed."
      render :new
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(
      customer_attributes: [:name, :email, addresses_attributes: [:address_line_1, :address_line_2, :city, :province, :postal_code, :country]]
    )
  end

  def calculate_total
    subtotal = @cart['items'].sum do |item|
      product = Product.find(item['product_id'])
      product.price * item['quantity']
    end

    province = order_params[:customer_attributes][:addresses_attributes]["0"][:province]
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
