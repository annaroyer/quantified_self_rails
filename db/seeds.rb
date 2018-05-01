meal_names = ["Breakfast", "Lunch", "Snack", "Dinner"]

meal_names.each do |name|
  meal = Meal.create!(name: name)
  3.times do
    meal.foods.create(name: Faker::Food.ingredient, calories: rand(50..1000))
  end
end
