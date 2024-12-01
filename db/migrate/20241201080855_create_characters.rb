class CreateCharacters < ActiveRecord::Migration[7.0]
  def change
    create_table :characters do |t|
      t.string :name, null: false
      t.integer :health, null: false, default: 60
      t.integer :attack_points, null: false, default: 60

      t.timestamps
    end
  end
end
