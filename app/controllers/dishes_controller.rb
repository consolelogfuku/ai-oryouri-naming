class DishesController < ApplicationController
  def index
  end

  def new
    @dish = Dish.new
    @cooking_methods = CookingMethod.all
    @seasonings = Seasoning.all
    @textures = Texture.all
    @categories = Category.all
  end

  def create
    # @dish = current_user.dishes.build(dish_params)
    #   if @dish.save

    #   end
  end

  def edit
  end

  def show
  end

  def update
  end

  def destroy
  end

  private

  def dish_params
    params.require(:dish).permit(:seasoning_id, :texture_id, :category_id, :point, :dish_image)
  end


end