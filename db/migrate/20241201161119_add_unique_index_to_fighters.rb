class AddUniqueIndexToFighters < ActiveRecord::Migration[7.0]
  def change
    add_index :fighters, [:battle_id, :character_id], unique: true, name: 'index_fighters_on_battle_id_and_character_id'
  end
end
