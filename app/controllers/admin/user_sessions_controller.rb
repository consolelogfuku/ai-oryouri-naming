module Admin
  class UserSessionsController < Admin::BaseController
    skip_before_action :require_login, only: %i[new create]

    def new; end

    def create
      @user = login(params[:email], params[:password])

      if @user
        # ダッシュボードへ飛ばす
        redirect_back_or_to admin_root_path, success: t('.success')
      else
        flash.now[:warning] = t('.fail')
        render :new, status: :unprocessable_entity
      end
    end

    def destroy
      logout
      redirect_to admin_login_path, success: t('.success'), status: :see_other
    end
  end
end
