require 'rails_helper'

describe 'Foods API' do
  describe 'get /api/v1/foods' do
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

  context 'get /api/v1/foods/:id' do
    it 'returns the food object with the specified id' do
      banana = Food.create!(name: 'Banana', calories: 150)

      get "/api/v1/foods/#{banana.id}"

      food = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(food[:id]).to eq(banana.id)
      expect(food[:name]).to eq(banana.name)
      expect(food[:calories]).to eq(banana.calories)
    end

    it 'returns a 404 if the food is not found' do
      get '/api/v1/foods/1'

      expect(response.status).to eq(404)
    end
  end

  context 'post /api/v1/foods' do
    it 'creates a new food and returns the food item' do
      create_list(:food, 2)
      expect(Food.count).to eq(2)

      post '/api/v1/foods', params: { "food": { "name": "Banana", "calories": "150"} }

      banana = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(banana[:name]).to eq("Banana")
      expect(banana[:calories]).to eq(150)
      expect(Food.count).to eq(3)
    end

    it 'returns a 400 if food is not created successfully' do
      post '/api/v1/foods', params: { "food": {"calories": "150"} }

      expect(response.status).to eq(400)

      post '/api/v1/foods', params: { "food": {"name": "banana"} }

      expect(response.status).to eq(400)
    end
  end

  context 'patch /api/v1/foods/:id' do
    it 'updates an existing food and returns the food item' do
      banana = Food.create!(name: 'Banana', calories: 150)

      patch "/api/v1/foods/#{banana.id}", params: {"food":{"name": "chocolate covered banana", "calories": "400"} }

      chocolate_covered = JSON.parse(response.body, symbolize_names: true)
      new_banana = Food.find(banana.id)

      expect(response).to be_success
      expect(chocolate_covered[:name]).to eq("chocolate covered banana")
      expect(chocolate_covered[:calories]).to eq(400)
      expect(new_banana.name).to eq(chocolate_covered[:name])
      expect(new_banana.calories).to eq(chocolate_covered[:calories])
    end

    it 'returns a 404 if food cannot be found' do
      patch'/api/v1/foods/1', params: {"food":{"name": "chocolate covered banana", "calories": "400"} }

      expect(response.status).to eq(404)
    end
  end

  context 'delete /api/v1/foods/:id' do
    it 'deletes the food with given id and returns a 204 status code' do
      banana = Food.create!(name: 'Banana', calories: 150)

      expect(Food.count).to eq(1)

      delete "/api/v1/foods/#{banana.id}"

      expect(response.status).to eq(204)
      expect(Food.count).to eq(0)
    end

    it 'returns a 404 if food cannot be found' do
      delete '/api/v1/foods/1'

      expect(response.status).to eq(404)
    end
  end
end
