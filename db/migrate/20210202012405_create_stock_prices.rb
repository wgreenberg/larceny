class CreateStockPrices < ActiveRecord::Migration[6.1]
  def change
    create_table :stock_prices do |t|
      t.references :company, null: false, foreign_key: true
      t.decimal :price, precision: 10, scale: 2
      t.integer :sim_time

      t.timestamps
    end
  end
end
