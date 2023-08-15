class Category < DishAttribute
  has_many :dishes, dependent: :destroy
end
