class CreateFighters < ActiveRecord::Migration[7.0]
  def change
    create_table :fighters do |t|
      t.references :character, null: false, foreign_key: true
      t.references :battle, null: false, foreign_key: true
      t.boolean :winner, default: false

      t.timestamps
    end
  end
end
