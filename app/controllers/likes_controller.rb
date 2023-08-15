class LikesController < ApplicationController
  def create
    dish = Dish.find_by(uuid: params[:uuid])
    current_user.like(dish)
    redirect_to params[:redirect_path]
  end

  def destroy
    dish = current_user.like_dishes.find_by(uuid: params[:uuid])
    current_user.unlike(dish)
    redirect_to params[:redirect_path], status: :see_other
  end
end
