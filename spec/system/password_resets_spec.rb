require 'rails_helper'

RSpec.describe "PasswordResets", type: :system do
  let(:user) { create(:user) }

  describe 'メールを送信' do
    before do
      visit  login_path
      click_on 'パスワードをお忘れの方はこちら'
    end

    fit 'メールアドレスを入力' do
      fill_in 'email', with: user.email
      click_on '再設定メールを送信'
      expect(page).to have_content('再設定メールを送信しました')
      mail = ActionMailer::Base.deliveries.last # ActionMailer::Base.deliveries.lastは最後に送信されたメールの情報を返却
      expect(mail.to).to include user.email
      expect(mail.subject).to eq 'パスワードの再設定について'
    end
  end
end
