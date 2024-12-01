require 'rails_helper'

RSpec.describe Character, type: :model do
  describe 'validations' do
    let(:character) { Character.new(name: "Hero", health: 60, attack_points: 60, precision: 60) }

    it 'is valid with valid attributes' do
      expect(character).to be_valid
    end

    it 'is invalid without a name' do
      character.name = nil
      expect(character).not_to be_valid
      expect(character.errors[:name]).to include("can't be blank")
    end

    it 'is invalid with a duplicate name (case insensitive)' do
      Character.create!(name: "Hero", health: 60, attack_points: 60, precision: 60)
      duplicate_character = Character.new(name: "hero", health: 60, attack_points: 60, precision: 60)
      expect(duplicate_character).not_to be_valid
      expect(duplicate_character.errors[:name]).to include("has already been taken")
    end

    it 'is invalid if health, attack points, or precision are less than or equal to zero' do
      character.health = 0
      expect(character).not_to be_valid
      expect(character.errors[:health]).to include("must be greater than 0")

      character.attack_points = -10
      expect(character).not_to be_valid
      expect(character.errors[:attack_points]).to include("must be greater than 0")

      character.precision = -5
      expect(character).not_to be_valid
      expect(character.errors[:precision]).to include("must be greater than 0")
    end

    it 'is invalid if the total points exceed 200' do
      character.health = 100
      character.attack_points = 90
      character.precision = 20
      expect(character).not_to be_valid
      expect(character.errors[:base]).to include("The total of health, attack points, and precision cannot exceed 200")
    end

    it 'is valid if the total points are exactly 200' do
      character.health = 80
      character.attack_points = 60
      character.precision = 60
      expect(character).to be_valid
    end

    it 'is valid if the total points are less than 200' do
      character.health = 50
      character.attack_points = 50
      character.precision = 50
      expect(character).to be_valid
    end
  end
end
