# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :set_product, only: [:show]
  before_action :set_product_breadcrumbs, only: [:show]

  def index
    @categories = Category.all
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true)

    case params[:filter]
    when 'on_sale'
      @products = @products.on_sale
    when 'new'
      @products = @products.new_products
    when 'recently_updated'
      @products = @products.recently_updated
    end

    @products = @products.page(params[:page])
  end

  def show; end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def set_product_breadcrumbs
    add_breadcrumb 'Categories', categories_path
    add_breadcrumb @product.category.name, category_path(@product.category)
    add_breadcrumb @product.name, product_path(@product)
  end
end
