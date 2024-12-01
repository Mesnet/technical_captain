class Weapon < ApplicationRecord
  has_many :fighter_weapons, dependent: :destroy
  has_many :fighters, through: :fighter_weapons

	has_one_attached :icon

  validates :name, presence: true
  validates :health, :attack_points, :precision, numericality: { greater_than_or_equal_to: 0 }
end