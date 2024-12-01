class Battle < ApplicationRecord
  has_many :fighters, dependent: :destroy
  has_many :characters, through: :fighters

  validate :must_have_at_least_two_fighters

  def winner
    fighters.find_by(winner: true)&.character
  end

  private

  def must_have_at_least_two_fighters
    if fighters.size < 2
      errors.add(:fighters, "must have at least two fighters to start a battle")
    end
  end
end