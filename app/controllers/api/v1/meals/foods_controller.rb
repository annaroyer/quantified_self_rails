class Api::V1::Meals::FoodsController < ApplicationController
  def index
    render json: Meal.find(params[:meal_id])
  end

  def create
    render json: MealFood.create(meal_food_params), status: 201
  end

  def destroy
    meal_food = MealFood.find_by(meal_food_params)
    meal_food.destroy
    render json: { message: "Successfully removed #{food.name} from #{meal.name}" }, status: 201
  end

  private

    def meal_food_params
      { meal: meal, food: food }
    end

    def meal
      Meal.find(params[:meal_id])
    end

    def food
      Food.find(params[:id])
    end
end
