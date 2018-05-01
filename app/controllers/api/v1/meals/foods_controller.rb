class Api::V1::Meals::FoodsController < ApplicationController
  def index
    render json: Meal.find(params[:meal_id])
  end

  def create
    render json: MealFood.create(meal_food_params), status: 201
  end

  private

    def meal_food_params
      { meal: Meal.find(params[:meal_id]), food: Food.find(params[:id]) }
    end
end
