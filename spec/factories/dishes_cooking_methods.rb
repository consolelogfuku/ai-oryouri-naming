FactoryBot.define do
  factory :dishes_cooking_method do
    association :dish
    association :cooking_method
  end
end
