require 'rails_helper'

RSpec.describe Battle, type: :model do
  describe 'associations' do
    it { should have_many(:fighters).dependent(:destroy) }
    it { should have_many(:characters).through(:fighters) }
  end

  describe 'validations' do
    let(:battle) { build(:battle) }

    context 'when there are at least two fighters' do
      it 'is valid' do
        character1 = create(:character)
        character2 = create(:character)
        battle.fighters.build(character: character1)
        battle.fighters.build(character: character2)
        expect(battle).to be_valid
      end
    end

  end

  describe '#winner' do
    let!(:battle) { create(:battle) }
    let!(:character1) { create(:character, name: "Hero 1") }
    let!(:character2) { create(:character, name: "Hero 2") }
    let!(:fighter1) { create(:fighter, battle: battle, character: character1, winner: true) }
    let!(:fighter2) { create(:fighter, battle: battle, character: character2, winner: false) }

    context 'when a winner exists' do
      it 'returns the winning character' do
        expect(battle.winner).to eq(character1)
      end
    end

    context 'when no winner exists' do
      it 'returns nil' do
        fighter1.update(winner: false)
        expect(battle.winner).to be_nil
      end
    end
  end
end
