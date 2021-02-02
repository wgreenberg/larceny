class CreateSellOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :sell_orders do |t|
      t.references :player, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true
      t.integer :sim_time
      t.integer :quantity

      t.timestamps
    end
  end
end
