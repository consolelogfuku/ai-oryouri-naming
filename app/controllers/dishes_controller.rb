class DishesController < ApplicationController
  skip_before_action :require_login, only: %i[index new show create result]
  before_action :setup_dish, only: %i[new create] # createメソッドでは、else句が走った場合に必要

  def index
    # 公開中のみ表示させる
    @dishes = Dish.includes(:user).where(state: 'published').order(created_at: :DESC).page(params[:page])
  end

  def show
    @dish = Dish.find_by(uuid: params[:uuid])
  end

  def new
    @generate_form = GenerateForm.new
    @dish = Dish.new
  end

  def edit
    @dish = current_user.dishes.find_by(uuid: params[:uuid])
  end

  def create
    @generate_form = GenerateForm.new(generate_params)
    @dish = @generate_form.setup_dish(current_user)
    if @dish.save
      redirect_to result_dish_path(@dish.uuid)
    else
      flash.now[:warning] = t('.fail')
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @dish = current_user.dishes.find_by(uuid: params[:uuid])
    if @dish.update(update_params)
      redirect_to edit_dish_path, success: t('.success')
    else
      flash.now[:warning] = t('.fail')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @dish = current_user.dishes.find_by(uuid: params[:uuid])
    @dish.destroy!
    redirect_to params[:redirect_path], success: t('.success'), status: :see_other
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

  # いいね一覧を取得
  def likes
    @likes = current_user.like_dishes.includes(:user).order(created_at: :DESC)
  end

  private

  def generate_params
    params.require(:generate_form).permit(:name_1, :name_2, :name_3, { cooking_methods: [] }, :seasoning_id,
                                          :texture_id, :category_id, :point, :dish_image, :dish_image_cache)
  end

  def update_params
    params.require(:dish).permit(:dish_image, :status)
  end

  # 選択肢を生成するのに必要
  def setup_dish
    @cooking_methods = CookingMethod.all
    @seasonings = Seasoning.all
    @textures = Texture.all
    @categories = Category.all
  end
end
