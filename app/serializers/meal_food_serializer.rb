class MealFoodSerializer < ActiveModel::Serializer
  attributes :message

  def message
    "Successfully added #{object.food.name} to #{object.meal.name}"
  end
end
