class OauthsController < ApplicationController
  skip_before_action :require_login # applications_controllerでbefore_action :require_loginを設定している

  # ユーザーをプロバイダに送る
  def oauth
    login_at(auth_params[:provider])
  end

  # ログイン認証時に呼ばれる
  def callback
    provider = auth_params[:provider]
    if (@user = login_from(provider)) # 既にSNSログインしたとこがある場合
      redirect_to root_path, success: t('.success')
    elsif @user = User.find_by(email: @user_hash[:user_info]['email']) # 手打ちでメールアドレスが既に登録されていた場合
      auto_login(@user) # 既存のuserでログインする
      redirect_to root_path, success: t('.success')
    else
      @user = create_from(provider) # 初めてSNSログインを使用する場合
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
