class Api::V1::FoodsController < ApplicationController
  def index
    render json: Food.all
  end

  def show
    render json: Food.find(params[:id])
  end

  def create
    render json: Food.create(food_params)
  end

  private

    def food_params
      params.require(:food).permit(:name, :calories)
    end
end
