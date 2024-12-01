require 'rails_helper'

RSpec.describe CharactersController, type: :request do
  let!(:character) { create(:character) }

  describe 'GET #index' do
    it 'returns a successful response' do
      get characters_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #new' do
    it 'returns a successful response' do
      get new_character_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    let(:character_params) do
      {
        name: 'Test Character',
        health: 60,
        attack_points: 60,
        precision: 60
      }
    end

    it 'creates a new character' do
      expect {
        post characters_path, params: { character: character_params }
      }.to change(Character, :count).by(1)

      expect(response).to redirect_to(character_path(Character.last))
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      get character_path(character)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #edit' do
    it 'returns a successful response' do
      get edit_character_path(character)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH #update' do
    let(:updated_params) { { attack_points: character.attack_points, health: character.health, name: character.name } }

    it 'updates the character and redirects to the character page' do
      patch character_path(character), params: { character: updated_params }
      expect(response).to redirect_to(character_path(character))
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the character and redirects to the characters index page' do
      expect {
        delete character_path(character)
      }.to change(Character, :count).by(-1)

      expect(response).to redirect_to(characters_path)
    end
  end
end
