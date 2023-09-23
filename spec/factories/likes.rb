FactoryBot.define do
  factory :like do
    association :user
    association :dish
  end
end
