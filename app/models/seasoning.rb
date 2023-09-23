class Seasoning < DishAttribute
  has_many :dishes, dependent: :destroy
end