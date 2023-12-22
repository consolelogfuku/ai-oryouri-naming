module Admin
  class DishesController < Admin::BaseController
    def index
      @dishes = Dish.includes(:user).order(created_at: :DESC).page(params[:page])
    end

    def show
      @dish = Dish.find_by(uuid: params[:uuid])
    end

    def destroy
      @dish = Dish.find_by(uuid: params[:uuid])
      @dish.destroy!
      redirect_to admin_dishes_path, success: t('.success'), status: :see_other
    end
  end
end
