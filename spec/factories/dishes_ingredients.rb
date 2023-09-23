FactoryBot.define do
  factory :dishes_ingredient do
    association :dish
    association :ingredient
  end
end
