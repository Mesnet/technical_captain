class Fighter < ApplicationRecord
  belongs_to :battle
  belongs_to :character
  has_many :fighter_weapons, dependent: :destroy
  has_many :weapons, through: :fighter_weapons

  # This validation ensures that a character can only participate once in a battle.
  validates :character_id, uniqueness: { scope: :battle_id, message: "can only participate once per battle" }
end
