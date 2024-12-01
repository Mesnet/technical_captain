class CreateWeapons < ActiveRecord::Migration[7.0]
  def change
    create_table :weapons do |t|
      t.string :name, null: false
      t.integer :health, null: false, default: 0
      t.integer :attack_points, null: false, default: 0
      t.integer :precision, null: false, default: 0

      t.timestamps
    end
  end
end