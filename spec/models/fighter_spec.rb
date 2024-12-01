require 'rails_helper'

RSpec.describe Fighter, type: :model do
  let(:battle) { create(:battle) }
  let(:character) { create(:character) }

  it 'allows a character to participate in one battle only once' do
    create(:fighter, battle: battle, character: character)
    duplicate_fighter = build(:fighter, battle: battle, character: character)

    expect(duplicate_fighter).not_to be_valid
    expect(duplicate_fighter.errors[:character_id]).to include("can only participate once per battle")
  end

  it 'allows the same character in different battles' do
    create(:fighter, battle: battle, character: character)
    new_battle = create(:battle)
    another_fighter = build(:fighter, battle: new_battle, character: character)

    expect(another_fighter).to be_valid
  end
end
