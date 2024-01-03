module AdminLoginMacros
  def admin_login
    visit admin_login_path
    fill_in 'email', with: ENV['ADMIN_EMAIL']
    fill_in 'password', with: ENV['ADMIN_PASSWORD']
    click_on 'ログイン'
  end
end
