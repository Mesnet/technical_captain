class Character < ApplicationRecord
	has_one_attached :avatar

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :health, :attack_points, numericality: { greater_than: 0 }
end
