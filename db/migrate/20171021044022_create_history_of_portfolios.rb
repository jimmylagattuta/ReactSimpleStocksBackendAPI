class CreateHistoryOfPortfolios < ActiveRecord::Migration[5.0]
  def change
    create_table :history_of_portfolios do |t|
      t.integer :user_id
      t.integer :portfolio_id
      t.text :notes
      t.integer :purchases
      t.integer :sales
      t.string :gain_or_loss
      t.integer :capital
      t.boolean :completed_without_error
      t.text :sales_notes
      t.text :purchases_notes
      t.integer :total_investment
      t.string :total_investment_breakeven

      t.timestamps
    end
  end
end
