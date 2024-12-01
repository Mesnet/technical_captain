class CreateFighterWeapons < ActiveRecord::Migration[7.0]
  def change
    create_table :fighter_weapons do |t|
      t.references :fighter, null: false, foreign_key: true
      t.references :weapon, null: false, foreign_key: true

      t.timestamps
    end
  end
end
