class ProductsController < ApplicationController
  before_action :set_product, only: [:show]

  def index
    @categories = Category.all
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true)

    if params[:filter] == 'on_sale'
      @products = @products.on_sale
    elsif params[:filter] == 'new'
      @products = @products.new_products
    elsif params[:filter] == 'recently_updated'
      @products = @products.recently_updated
    end

    @products = @products.page(params[:page])
  end

  def show
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end
end
