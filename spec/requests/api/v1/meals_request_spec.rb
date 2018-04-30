require 'rails_helper'

describe 'Meals API' do
  context 'get /api/v1/meals' do
    it 'returns all the meals in the database along with their associated foods' do
      raw_meals.each do |raw_meal|
        meal = Meal.create!(name: raw_meal[:name])
        raw_meal[:foods].each do |raw_food|
          food = Food.find_or_create_by(raw_food)
          MealFood.create!(food: food, meal: meal)
        end
      end

      get '/api/v1/meals'

      meals = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(meals.first[:name]).to eq(Meal.first.name)
      expect(meals.first[:foods].count).to eq(Meal.first.foods.count)
      expect(meals.first[:foods]).to include({id: 1, name: "Banana", calories: 150})
      expect(meals.last[:foods].count).to eq(Meal.last.foods.count)
      expect(meals.last[:foods]).to include({id: 1, name: "Banana", calories: 150})
      expect(meals.last[:name]).to eq(Meal.last.name)
    end
  end
end


def raw_meals
  [
    {
      id: 1,
      name: "Breakfast",
      foods: [
        {
        id: 1,
        name: "Banana",
        calories: 150
        },
        {
        id: 6,
        name: "Yogurt",
        calories: 550
        },
        {
        id: 12,
        name: "Apple",
        calories: 220
        }
      ]
    },
    {
      id: 2,
      name: "Snack",
      foods: [
        {
        id: 1,
        name: "Banana",
        calories: 150
        },
        {
        id: 9,
        name: "Gum",
        calories: 50
        },
        {
        id: 10,
        name: "Cheese",
        calories: 400
        }
      ]
    },
    {
      id: 3,
      name: "Lunch",
      foods: [
        {
        id: 2,
        name: "Bagel Bites - Four Cheese",
        calories: 650
        },
        {
        id: 3,
        name: "Chicken Burrito",
        calories: 800
        },
        {
        id: 12,
        name: "Apple",
        calories: 220
        }
      ]
    },
    {
      id: 4,
      name: "Dinner",
      foods: [
        {
        id: 1,
        name: "Banana",
        calories: 150
        },
        {
        id: 2,
        name: "Bagel Bites - Four Cheese",
        calories: 650
        },
        {
        id: 3,
        name: "Chicken Burrito",
        calories: 800
        }
      ]
    }
]
end
