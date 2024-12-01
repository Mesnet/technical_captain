class AddPrecisionToCharacters < ActiveRecord::Migration[7.0]
  def change
    add_column :characters, :precision, :integer, null: false, default: 60
  end
end
