class Battle < ApplicationRecord
  has_many :fighters, dependent: :destroy
  has_many :characters, through: :fighters
  has_one :winning_fighter, -> { where(winner: true) }, class_name: 'Fighter'
  has_one :winner, through: :winning_fighter, source: :character

  validate :must_have_at_least_two_fighters

  private

  def must_have_at_least_two_fighters
    if fighters.size < 2
      errors.add(:fighters, "must have at least two fighters to start a battle")
    end
  end
end