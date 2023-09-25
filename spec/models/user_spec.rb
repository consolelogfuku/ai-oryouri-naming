require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'varidation' do
    # 全部ちゃんと入力
    it 'is valid with all attributes' do
      user = create(:user)
      expect(user).to be_valid # be_validはテストの対象に対して、'valid?'を呼ぶ
      expect(user.errors).to be_empty
    end

    # 名前なし
    it 'is invalid without name' do
      user_without_name = build(:user, name: '')
      expect(user_without_name).to be_invalid
      expect(user_without_name.errors.full_messages).to eq ['ニックネームを入力してください']
    end

    # 名前が15文字より多い
    it 'is invalid name longer than 15 characters' do
      user_with_longer_name = build(:user, name: 'あいうえおかきくけこさしすせそたちつてと')
      expect(user_with_longer_name).to be_invalid
      expect(user_with_longer_name.errors.full_messages).to eq ['ニックネームは15文字以内で入力してください']
    end

    # メールアドレスなし
    it 'is invalid without email' do
      user_without_email = build(:user, email: '')
      expect(user_without_email).to be_invalid
      expect(user_without_email.errors.full_messages).to eq ['メールアドレスを入力してください']
    end

    # メールアドレスの重複
    it 'is invalid with same email' do
      user = create(:user)
      user_with_same_email = build(:user, email: user.email)
      user_with_same_email.valid?
      expect(user_with_same_email).to be_invalid
      expect(user_with_same_email.errors.full_messages).to eq ['メールアドレスはすでに存在します']
    end

    # パスワードなし
    it 'is invalid without password' do
      user_without_password = build(:user, password: '')
      expect(user_without_password).to be_invalid
      expect(user_without_password.errors.full_messages).to eq %w[パスワードは8文字以上で入力してください パスワード確認とパスワードの入力が一致しません]
    end

    # パスワード確認なし
    it 'is invalid without password_confirmation' do
      user_without_password_confirmation = build(:user, password_confirmation: '')
      expect(user_without_password_confirmation).to be_invalid
      expect(user_without_password_confirmation.errors.full_messages).to eq %w[パスワード確認とパスワードの入力が一致しません
                                                                               パスワード確認を入力してください]
    end
  end
end
