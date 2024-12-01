require 'rails_helper'

RSpec.describe BattlesController, type: :request do
  let!(:character1) { create(:character) }
  let!(:character2) { create(:character) }
  let!(:weapon1) { create(:weapon) }
  let!(:weapon2) { create(:weapon) }
  let!(:battle) { create(:battle) }

  describe 'POST #create' do
    let(:battle_params) do
      {
        fighters: [
          { character_id: character1.id, weapon_ids: [weapon1.id] },
          { character_id: character2.id, weapon_ids: [weapon2.id] }
        ].to_json
      }
    end

    it 'creates a new battle' do
      expect {
        post battles_path, params: { battle: battle_params }
      }.to change(Battle, :count).by(1)

      expect(response).to redirect_to(battle_path(Battle.last))
    end
  end

  describe 'GET #index' do
    it 'returns a successful response' do
      get battles_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include(battle.id.to_s) # Adjust to ensure it verifies index content
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      get battle_path(battle)
      expect(response).to have_http_status(:success)
      expect(response.body).to include(battle.id.to_s) # Adjust to ensure it verifies show content
    end
  end

  describe 'GET #new' do
    it 'returns a successful response' do
      get new_battle_path
      expect(response).to have_http_status(:success)
      expect(assigns(:characters)).to include(character1, character2)
      expect(assigns(:weapons)).to include(weapon1, weapon2)
    end
  end
end
