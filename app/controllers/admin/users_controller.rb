module Admin
  class UsersController < Admin::BaseController
    def index
      @users = User.where.not(name: 'guest_user').order(created_at: :ASC).page(params[:page])
    end

    def destroy
      @user = User.find_by(uuid: params[:uuid])
      @user.destroy!
      redirect_to admin_users_path, success: t('.success'), status: :see_other
    end

  end
end
