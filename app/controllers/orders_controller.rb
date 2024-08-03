# app/controllers/orders_controller.rb
class OrdersController < ApplicationController
  before_action :initialize_cart, only: [:new, :create]
  before_action :authenticate_user!

  def index
    @orders = current_user.orders.includes(order_items: :product).order(created_at: :desc)
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
    @order.order_status = "pending" # Use order_status instead of status

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

      redirect_to @order, notice: "Order was successfully created."
    else
      @order.customer.addresses.build unless @order.customer.addresses.any?
      flash[:alert] = "Order creation failed: #{@order.errors.full_messages.join(', ')}"
      render :new
    end
  end

  private

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
