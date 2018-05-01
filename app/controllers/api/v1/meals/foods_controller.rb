class Api::V1::Meals::FoodsController < ApplicationController
  def index
    render json: Meal.find(params[:meal_id])
  end

  def create
    MealFood.create(meal: meal, food: food)
    message = "Successfully added #{food.name} to #{meal.name}"
    render json: { message: message }, status: :created
  end

  def destroy
    MealFood.find_by(meal: meal, food: food).destroy
    message = "Successfully removed #{food.name} from #{meal.name}"
    render json: { message: message }
  end

  private

    def meal
      Meal.find(params[:meal_id])
    end

    def food
      Food.find(params[:id])
    end
end
