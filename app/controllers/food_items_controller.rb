class FoodItemsController < ApplicationController
  include FoodItemsHelper

  def index
    @food_tems = FoodItem.all
  end

  def new

  end

  def create

      #@food_item = FoodItem.new(food_item_params)

      @food_item.save

      redirect_to @food_item

  end


  def update

  end

  def delete

  end

  private
  def food_item_params
    params.require(:food_item).permit(:name, :modifiers, :availability, :price)
  end

end
