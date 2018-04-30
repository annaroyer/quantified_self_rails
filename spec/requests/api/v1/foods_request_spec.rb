require 'rails_helper'

describe 'Foods API' do
  context '/api/v1/foods' do
    it 'returns all foods currently in the database' do
      create_list(:food, 5)

      get '/api/v1/foods'

      food = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(food.count).to eq(5)
      expect(food.first[:id]).to eq(1)
      expect(food.first[:name]).to be_a(String)
      expect(food.first[:calories]).to be_an(Integer)
    end
  end

  context '/api/v1/foods/:id' do
    it 'returns the food object with the specified id' do
      banana = Food.create!(name: 'Banana', calories: 150)

      get "/api/v1/foods/#{banana.id}"

      food = JSON.parse(response.body, symbolize_names: true)

      expect(food[:id]).to eq(banana.id)
      expect(food[:name]).to eq(banana.name)
      expect(food[:calories]).to eq(banana.calories)
    end
  end
end
