class Api::V1::Meals::FoodsController < ApplicationController
  def index
    render json: Meal.find(params[:meal_id])
  end
end
