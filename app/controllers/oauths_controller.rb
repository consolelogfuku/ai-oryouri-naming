class OauthsController < ApplicationController
  skip_before_action :require_login # applications_controllerでbefore_action :require_loginを設定している

  # ユーザーをプロバイダに送る
  def oauth
    login_at(auth_params[:provider])
  end

  # ログイン認証時に呼ばれる
  def callback
    provider = auth_params[:provider]
    if (@user = login_from(provider)) # 既に一度ログインしたとこがある場合
    else
      @user = create_from(provider)
      reset_session
      auto_login(@user)
    end
    redirect_to root_path, success: t('.success')
  end

  private

  def auth_params
    params.permit(:code, :provider, :error, :state)
  end
end
