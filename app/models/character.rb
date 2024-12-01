class Character < ApplicationRecord
  has_many :fighters
  has_many :battles, through: :fighters

	has_one_attached :avatar

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :health, :attack_points, :precision, numericality: { greater_than: 0 }
  validate :total_points_cannot_exceed_limit

  private

  def total_points_cannot_exceed_limit
    total = health.to_i + attack_points.to_i + precision.to_i
    if total > 200
      errors.add(:base, "The total of health, attack points, and precision cannot exceed 200")
    end
  end
end
