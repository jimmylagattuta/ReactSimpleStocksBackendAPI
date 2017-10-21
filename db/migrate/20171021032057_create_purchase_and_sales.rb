class CreatePurchaseAndSales < ActiveRecord::Migration[5.0]
  def change
    create_table :purchase_and_sales do |t|
      t.integer :portfolio_id
      t.integer :user_id
      t.string :status
      t.string :p_or_s

      t.timestamps
    end
  end
end
