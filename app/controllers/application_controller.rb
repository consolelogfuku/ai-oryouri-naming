class ApplicationController < ActionController::Base
  before_action :require_login
  add_flash_types :success, :info, :warning, :danger
  skip_before_action :require_login, if: :high_voltage_page?

  private

  def not_authenticated
    redirect_to login_path, warning: t('defaults.message.require_login')
  end

  # 利用規約・プライバシーページにはrequire_loginを適用させない
  # HighVoltage::PagesControllerで処理したページはログインを要求しない
  def high_voltage_page?
    params[:controller] == 'high_voltage/pages'
  end
end