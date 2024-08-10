class CategoriesController < ApplicationController
  before_action :set_category, only: [:show]
  before_action :set_category_breadcrumbs, only: [:show]

  def index
    @categories = Category.all
  end

  def show
    @q = @category.products.ransack(params[:q])
    @products = @q.result.page(params[:page])
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def set_category_breadcrumbs
    # Ensure @category is not nil
    if @category
      add_breadcrumb "Categories", categories_path
      add_breadcrumb @category.name, category_path(@category)
    end
  end
end
