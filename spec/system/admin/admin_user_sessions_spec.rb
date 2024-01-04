require 'rails_helper'

RSpec.describe 'AdminUserSessions', type: :system do
  describe 'ログイン前' do
    before do
      visit admin_login_path
    end
    context 'フォームの入力値が正常' do
      it 'ログインが成功する' do
        fill_in 'email', with: ENV['ADMIN_EMAIL']
        fill_in 'password', with: ENV['ADMIN_PASSWORD']
        click_on 'ログイン'
        expect(page).to have_content('ログインしました')
        expect(current_path).to eq admin_root_path
      end
    end
    context 'メールアドレスが未入力' do
      it 'ログインが失敗する' do
        fill_in 'email', with: ENV['ADMIN_EMAIL']
        fill_in 'password', with: ''
        click_on 'ログイン'
        expect(page).to have_content('ログインに失敗しました')
        expect(current_path).to eq admin_login_path
      end
    end
    context 'パスワードが未入力' do
      fit 'ログインが失敗する' do
        fill_in 'email', with: ''
        fill_in 'password', with: ENV['ADMIN_PASSWORD']
        click_on 'ログイン'
        expect(page).to have_content('ログインに失敗しました')
        expect(current_path).to eq admin_login_path
      end
    end
  end
end
