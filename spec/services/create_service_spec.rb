require 'rails_helper'

RSpec.describe Battles::CreateService, type: :service do
  let!(:character1) { create(:character) }
  let!(:character2) { create(:character) }
  let!(:weapon1) { create(:weapon) }
  let!(:weapon2) { create(:weapon) }

  describe '#execute!' do
    context 'with valid parameters' do
      let(:valid_params) do
        {
          fighters: [
            { character_id: character1.id, weapon_ids: [weapon1.id] },
            { character_id: character2.id, weapon_ids: [weapon2.id] }
          ].to_json
        }
      end

      it 'creates a new battle and returns success' do
        service = Battles::CreateService.new(valid_params)
        result = service.execute!

        expect(result.success?).to be true
        expect(result.battle).to be_persisted
        expect(result.battle.fighters.count).to eq(2)
        expect(result.battle.fighters.map(&:character)).to contain_exactly(character1, character2)
        expect(result.battle.fighters.first.weapon_ids).to include(weapon1.id)
      end
    end

    context 'with less than two fighters' do
      let(:invalid_params) do
        {
          fighters: [
            { character_id: character1.id, weapon_ids: [weapon1.id] }
          ].to_json
        }
      end

      it 'returns a failure with an error message' do
        service = Battles::CreateService.new(invalid_params)
        result = service.execute!

        expect(result.success?).to be false
        expect(result.error).to eq("A battle requires at least 2 fighters.")
      end
    end

    context 'with invalid character_id' do
      let(:invalid_params) do
        {
          fighters: [
            { character_id: 999, weapon_ids: [weapon1.id] },
            { character_id: character2.id, weapon_ids: [weapon2.id] }
          ].to_json
        }
      end

      it 'returns a failure with an error message' do
        service = Battles::CreateService.new(invalid_params)
        result = service.execute!

        expect(result.success?).to be false
        expect(result.error).to eq("Invalid character or fighter data.")
      end
    end

    context 'when the battle cannot be saved' do
      let(:valid_params) do
        {
          fighters: [
            { character_id: character1.id, weapon_ids: [weapon1.id] },
            { character_id: character2.id, weapon_ids: [weapon2.id] }
          ].to_json
        }
      end

      before do
        allow_any_instance_of(Battle).to receive(:save).and_return(false)
      end

      it 'returns a failure with an error message' do
        service = Battles::CreateService.new(valid_params)
        result = service.execute!

        expect(result.success?).to be false
        expect(result.error).to eq("There was an issue creating the battle.")
      end
    end
  end
end
