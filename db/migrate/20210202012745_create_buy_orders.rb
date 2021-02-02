class CreateBuyOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :buy_orders do |t|
      t.references :player, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true
      t.integer :sim_time
      t.decimal :price, precision: 20, scale: 2

      t.timestamps
    end
  end
end
