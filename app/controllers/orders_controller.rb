# app/controllers/orders_controller.rb
class OrdersController < ApplicationController
  before_action :initialize_cart, only: [:new, :create]
  before_action :authenticate_user!

  def index
    @orders = current_user.orders.includes(:order_items => :product).order(created_at: :desc)
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  def new
    @order = current_user.orders.build
    if current_user.customer.nil?
      @order.build_customer
      @order.customer.addresses.build
    else
      @order.customer = current_user.customer
      @order.customer.addresses.build if @order.customer.addresses.empty?
    end
  end

  def create
    @order = current_user.orders.build(order_params)
    @order.order_status = "pending"

    if current_user.customer
      @order.customer = current_user.customer
      address_params = order_params[:customer_attributes][:addresses_attributes]["0"]
      province = Province.find_by(id: address_params[:province_id])
      if province
        @order.customer.province_id = province.id
        @order.customer.addresses.first.update(address_params)
      end
    else
      customer_params = order_params[:customer_attributes]
      province = Province.find_by(id: customer_params[:addresses_attributes]["0"][:province_id])
      if province
        customer_params[:province_id] = province.id
        @order.customer = current_user.build_customer(customer_params)
      end
    end

    @order.status = "unpaid"

    if @order.save
      @cart['items'].each do |item|
        product = Product.find(item['product_id'])
        @order.order_items.create(
          product: product,
          quantity: item['quantity'],
          price: product.price
        )
      end

      @order.update(total: @order.total)

      process_payment
    else
      @order.customer.addresses.build unless @order.customer.addresses.any?
      flash[:alert] = "Order creation failed: #{@order.errors.full_messages.join(', ')}"
      render :new
    end
  end

  private

  def process_payment
    charge = Stripe::Charge.create(
      amount: (@order.total * 100).to_i,
      currency: 'usd',
      description: "Order ##{@order.id}",
      source: params[:stripeToken]
    )

    if charge.paid
      @order.update(status: 'paid')
      session.delete(:cart)
      redirect_to @order, notice: "Order was successfully created and paid."
    else
      flash[:alert] = "Payment failed. Please try again."
      render :new
    end
  rescue Stripe::CardError => e
    flash[:alert] = e.message
    render :new
  end

  def order_params
    params.require(:order).permit(
      customer_attributes: [
        :name,
        :email,
        :province_id,
        addresses_attributes: [
          :address_line_1,
          :address_line_2,
          :city,
          :province_id,
          :postal_code,
          :country
        ]
      ]
    )
  end
end
