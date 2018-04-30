class Food < ApplicationRecord
  validates_presence_of :name, :calories
  validates_uniqueness_of :name
  has_many :meal_foods
  has_many :meals, through: :meal_foods
end
