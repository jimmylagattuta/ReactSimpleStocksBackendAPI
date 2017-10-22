class AddBudgetToUser < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :budget, :decimal, precision: 9, scale: 2
  end
end
