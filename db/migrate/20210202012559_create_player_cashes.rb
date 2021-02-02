class CreatePlayerCashes < ActiveRecord::Migration[6.1]
  def change
    create_table :player_cashes do |t|
      t.decimal :amount, precision: 20, scale: 2
      t.integer :sim_time
      t.references :player, null: false, foreign_key: true

      t.timestamps
    end
  end
end
