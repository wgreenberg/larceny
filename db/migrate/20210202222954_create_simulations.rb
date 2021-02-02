class CreateSimulations < ActiveRecord::Migration[6.1]
  def change
    create_table :simulations do |t|
      t.integer :sim_time
      t.integer :generation

      t.timestamps
    end
  end
end
