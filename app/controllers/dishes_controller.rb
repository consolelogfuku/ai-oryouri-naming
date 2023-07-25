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
    user = User.find(1)
    # 料理を保存
    @dish = user.dishes.build(dish_params)
    if @dish.save_with_ingredients_and_cooking_methods(name_1: params.dig(:dish, :name_1), name_2: params.dig(:dish, :name_2), name_3: params.dig(:dish, :name_3), cooking_methods_name: params.dig(:dish, :cooking_methods_name))
      redirect_to new_dish_path, notice: "料理を保存しました"
    else
      render :new
    end
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