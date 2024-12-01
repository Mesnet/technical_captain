class FighterWeapon < ApplicationRecord
  belongs_to :fighter
  belongs_to :weapon
end
