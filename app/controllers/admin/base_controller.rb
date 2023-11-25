module Admin
  class BaseController < ApplicationController
    # 管理者用controllerの共通の処理はここに書く
    before_action :check_admin

    # ログインしていなければ、ログイン画面に飛ばす
    def not_authenticated
      redirect_to admin_login_path, warning: t('defaults.message.require_login')
    end

    # 常にcurrent_userがadminかチェックする
    def check_admin
      redirect_to admin_login_path, warning: t('defaults.message.not_authorized') unless current_user.admin?
    end
  end
end
