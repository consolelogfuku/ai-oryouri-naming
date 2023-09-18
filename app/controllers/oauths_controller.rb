class OauthsController < ApplicationController
  skip_before_action :require_login # applications_controllerでbefore_action :require_loginを設定している

  # ユーザーをプロバイダに送る
  def oauth
    session[:oauth_provider] = auth_params[:provider]
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    if (@user = login_from(provider))
      redirect_to root_path, success: t('.success')
    else
      @user = create_from(provider)
      reset_session
      auto_login(@user)
      redirect_to root_path, success: t('.success')
    end
  end

  private

  def auth_params
    params.permit(:code, :provider, :error, :state)
  end
end
