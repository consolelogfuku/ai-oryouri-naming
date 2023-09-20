FactoryBot.define do
  factory :user do
    uuid {SecureRandom.uuid}
    sequence(:name) {|n| "user_#{n}"}
    sequence(:email) {|n| "user_#{n}@gmail"}
    password {"password1234"}
    password_confirmation {"password1234"}
    avatar {Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/factories/test.png')) }
  end
end
