class Admin::CategoriesController < ApplicationController

  def index
    @categories = Category.all
  end

  def new
  end

  def create
  end

  def category_params

  end

  
end



# def product_params
#   params.require(:product).permit(
#     :name,
#     :description,
#     :category_id,
#     :quantity,
#     :image,
#     :price
#   )
# end
