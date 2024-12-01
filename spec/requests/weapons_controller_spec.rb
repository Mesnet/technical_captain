require 'rails_helper'

RSpec.describe WeaponsController, type: :request do
  let!(:weapon) { create(:weapon) }

  describe 'POST #create' do
    let(:weapon_params) do
      {
        name: 'Test Weapon',
        health: 50,
        attack_points: 30,
        precision: 40
      }
    end

    it 'creates a new weapon' do
      expect {
        post weapons_path, params: { weapon: weapon_params }
      }.to change(Weapon, :count).by(1)

      expect(response).to redirect_to(weapons_path)
    end
  end

  describe 'PATCH #update' do
    let(:updated_params) { { name: 'Updated Weapon', health: 60, attack_points: 70, precision: 80 } }

    it 'updates the weapon and redirects to the weapons index page' do
      patch weapon_path(weapon), params: { weapon: updated_params }
      expect(response).to redirect_to(weapons_path)
      follow_redirect!
      expect(response.body).to include(weapon.reload.name) # Verify the updated weapon is listed
    end
  end

	describe 'GET #show' do
    it 'returns a successful response' do
      get weapon_path(weapon)
      expect(response).to have_http_status(:success)
      expect(response.body).to include(weapon.name)
    end
  end

	describe 'GET #edit' do
    it 'returns a successful response' do
      get edit_weapon_path(weapon)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the weapon and redirects to the weapons index page' do
      expect {
        delete weapon_path(weapon)
      }.to change(Weapon, :count).by(-1)

      expect(response).to redirect_to(weapons_path)
      follow_redirect!
      expect(response.body).not_to include(weapon.name) # Verify the weapon is no longer listed
    end
  end
end
