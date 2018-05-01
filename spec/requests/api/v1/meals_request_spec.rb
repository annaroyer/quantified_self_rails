require 'rails_helper'

describe 'Meals API' do
  before(:each) do
    raw_meals.each do |raw_meal|
      meal = Meal.create!(name: raw_meal[:name])
      raw_meal[:foods].each do |raw_food|
        food = Food.find_or_create_by(raw_food)
        MealFood.create!(food: food, meal: meal)
      end
    end
  end
  context 'get /api/v1/meals' do
    it 'returns all the meals in the database along with their associated foods' do
      get '/api/v1/meals'

      meals = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(meals.first[:name]).to eq(raw_meals.first[:name])
      expect(meals.last[:name]).to eq(raw_meals.last[:name])
      expect(meals.count).to eq(raw_meals.count)
      expect(meals.first[:foods].count).to eq(raw_meals.first[:foods].count)
      expect(meals.last[:foods].count).to eq(raw_meals.last[:foods].count)
      expect(meals.first[:foods]).to include({id: 1, name: "Banana", calories: 150})
      expect(meals.last[:foods]).to include({id: 1, name: "Banana", calories: 150})
    end
  end

  context 'get /api/v1/meals/:meal_id/foods' do
    it 'returns all the foods associated with the meal with the given meal_id' do
      get '/api/v1/meals/1/foods'

      meal = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(meal).to eq(raw_meals.first)
    end

    it 'returns a 404 if the meal with given id does not exist' do
      get '/api/v1/meals/5/foods'

      expect(response.status).to eq(404)
    end
  end
end


def raw_meals
  [
    {
      id: 1,
      name: "Breakfast",
      foods: [
        { id: 1, name: "Banana",calories: 150 },
        { id: 6, name: "Yogurt", calories: 550 },
        { id: 12, name: "Apple", calories: 220 }
      ]
    },
    {
      id: 2,
      name: "Snack",
      foods: [
        { id: 1, name: "Banana", calories: 150 },
        { id: 9, name: "Gum", calories: 50 },
        { id: 10, name: "Cheese", calories: 400 }
      ]
    },
    {
      id: 3,
      name: "Lunch",
      foods: [
        { id: 2, name: "Bagel Bites - Four Cheese", calories: 650 },
        { id: 3, name: "Chicken Burrito", calories: 800 },
        { id: 12, name: "Apple", calories: 220 }
      ]
    },
    {
      id: 4,
      name: "Dinner",
      foods: [
        { id: 1, name: "Banana", calories: 150 },
        { id: 2, name: "Bagel Bites - Four Cheese", calories: 650 },
        { id: 3, name: "Chicken Burrito", calories: 800 }
      ]
    }
  ]
end