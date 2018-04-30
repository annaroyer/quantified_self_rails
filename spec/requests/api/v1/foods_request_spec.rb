require 'rails_helper'

describe 'Foods API' do
  context '/api/v1/foods' do
    it 'returns all foods currently in the database' do
      create_list(:food, 5)

      get '/api/v1/foods'

      foods = JSON.parse(response.body)

      expect(response).to be_success
      expect(foods.count).to eq(5)
      expect(foods.first[:id]).to eq(1)
      expect(foods.first[:name]).to be_a(String)
      expect(foods.first[:calories]).to be_an(Integer)
    end
  end
end
