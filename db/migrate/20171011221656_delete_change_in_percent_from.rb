class DeleteChangeInPercentFrom < ActiveRecord::Migration[5.0]
  def change
  	remove_column :stocks, :changein_percent, :decimal
  end
end
