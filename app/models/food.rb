class Food < ApplicationRecord
  validates_presence_of :name, :calories
  validates_uniqueness_of :name
end
