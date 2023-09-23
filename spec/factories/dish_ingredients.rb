FactoryBot.define do
  factory :dish_ingredient do
    association :dish
    association :ingredient
  end
end
