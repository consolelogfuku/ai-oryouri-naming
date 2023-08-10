class DishesController < ApplicationController
  skip_before_action :require_login, only: %i[index new create result]
  before_action :setup_dish, only: %i[new create] # createメソッドでは、else句が走った場合に必要

  def index
    @dishes = Dish.includes(:user).order(created_at: :DESC).page(params[:page])
  end

  def new
    @dish = Dish.new
  end

  def create
    # 料理名生成時に、ログインしていなければ、自動的にゲストユーザー設定をする
    user = User.set_guest_if_not_logedin(current_user) # user.rb内でcurrent_userを使用できるようにするため、引数を渡す
    @dish = user.dishes.build(dish_params)
    if @dish.save_with_ingredients_and_cooking_methods(
      name_1: params[:dish][:name_1],
      name_2: params[:dish][:name_2],
      name_3: params[:dish][:name_3],
      cooking_methods_name: params[:dish][:cooking_methods_name]
    )
      redirect_to result_dish_path(@dish.uuid)
    else
      flash.now[:warning] = t('.fail')
      render :new, status: :unprocessable_entity
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

  def result
    @dish = Dish.find_by(uuid: params[:uuid])
  end

  # ステータスを公開に変更
  def publish
    @dish = Dish.find_by(uuid: params[:uuid])
    @dish.update!(state: 'published')
    flash.now[:success] = t('.success')
    render :result, status: :unprocessable_entity
  end

  private

  def dish_params
    params.require(:dish).permit(:seasoning_id, :texture_id, :category_id, :point, :dish_image)
  end

  def setup_dish # 選択肢を生成するのに必要
    @cooking_methods = CookingMethod.all
    @seasonings = Seasoning.all
    @textures = Texture.all
    @categories = Category.all
  end


end