class CreateEffects < ActiveRecord::Migration[6.1]
  def change
    create_table :effects do |t|
      t.references :company, null: false, foreign_key: true
      t.float :value
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
