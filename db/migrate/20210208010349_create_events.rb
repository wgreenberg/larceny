class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :description
      t.integer :sim_time
      t.integer :duration

      t.timestamps
    end
  end
end
