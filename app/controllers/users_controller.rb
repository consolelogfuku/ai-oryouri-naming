class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def show
    @user = User.find_by(uuid: params[:uuid])
    @dishes = @user.dishes.published.order(created_at: :DESC).page(params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user) # 新規ユーザー作成後、自動でログイン
      redirect_to root_path, success: t('.success')
    else
      flash.now[:warning] = t('.fail')
      render :new, status: :unprocessable_entity
    end
  end

  def my_dishes
    @dishes = current_user.dishes.order(created_at: :DESC).page(params[:page])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
