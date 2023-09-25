FactoryBot.define do
  factory :user do
    uuid { SecureRandom.uuid }
    sequence(:name, 'user_1') # user_1, user_2, user_3...と作成される
    sequence(:email) { |n| "user_#{n}@gmail" }
    password { 'password1234' }
    password_confirmation { 'password1234' }
    avatar { nil } # テスト環境でファイルのアップロードをシミュレートする
  end
end
