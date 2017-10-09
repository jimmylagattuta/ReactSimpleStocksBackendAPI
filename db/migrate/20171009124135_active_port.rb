class ActivePort < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :active_port, :boolean
  	add_column :users, :portfolios, :integer
  end
end
