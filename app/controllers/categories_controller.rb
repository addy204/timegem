class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    @q = @category.products.ransack(params[:q])
    @products = @q.result.page(params[:page])
  end
end
