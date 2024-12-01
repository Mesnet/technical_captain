require 'rails_helper'

RSpec.describe Battles::RunService, type: :service do
  let!(:battle) { create(:battle) }
  let!(:fighter1) { create(:fighter, battle: battle, winner: false) }
  let!(:fighter2) { create(:fighter, battle: battle, winner: false) }
  let!(:character1) { fighter1.character }
  let!(:character2) { fighter2.character }

  describe '#execute!' do
    it 'selects a winner and upgrades characters' do
      original_battle_experiences = { character1: character1.battle_experience, character2: character2.battle_experience }

      service = Battles::RunService.new(battle)
      result = service.execute!

      # Ensure the service returns the battle
      expect(result).to eq(battle)

      # Ensure a winner is selected
      expect(battle.fighters.where(winner: true).count).to eq(1)
      winner = battle.fighters.find_by(winner: true)
      expect(winner).not_to be_nil

      # Ensure all characters have their battle_experiences increased
      expect(character1.reload.battle_experience).to eq(original_battle_experiences[:character1] + 1)
      expect(character2.reload.battle_experience).to eq(original_battle_experiences[:character2] + 1)
    end

    context 'when selecting a winner fails' do
      it 'raises an error and does not upgrade characters' do
        allow_any_instance_of(Fighter).to receive(:update!).and_raise(ActiveRecord::RecordInvalid)

        service = Battles::RunService.new(battle)

        expect { service.execute! }.to raise_error(ActiveRecord::RecordInvalid)

        # Ensure no battle_experiences are upgraded
        expect(character1.reload.battle_experience).to eq(character1.battle_experience)
        expect(character2.reload.battle_experience).to eq(character2.battle_experience)
      end
    end

    context 'when upgrading battle_experiences fails' do
      it 'raises an error' do
        allow_any_instance_of(Character).to receive(:update!).and_raise(ActiveRecord::RecordInvalid)

        service = Battles::RunService.new(battle)

        expect { service.execute! }.to raise_error(ActiveRecord::RecordInvalid)

        # Ensure winner is still selected
        expect(battle.fighters.where(winner: true).count).to eq(1)
      end
    end
  end
end
