class Texture < DishAttribute
  has_many :dishes, dependent: :destroy
end
