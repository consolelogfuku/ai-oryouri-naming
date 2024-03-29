class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create show]

  def show
    @user = User.find_by(uuid: params[:uuid])
    @dishes = if @user == current_user
                @user.dishes.order(created_at: :DESC).page(params[:page])
              else
                @user.dishes.published.order(created_at: :DESC).page(params[:page]) # 公開中のもののみ取得
              end
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

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
