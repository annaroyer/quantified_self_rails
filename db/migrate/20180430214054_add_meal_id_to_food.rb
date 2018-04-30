class AddMealIdToFood < ActiveRecord::Migration[5.1]
  def change
    add_column :foods, :meal_id, :integer
    add_index :foods, :meal_id
  end
end
