class AddExperienceToCharacters < ActiveRecord::Migration[7.0]
  def change
    add_column :characters, :battle_experience, :integer, null: false, default: 1
  end
end
