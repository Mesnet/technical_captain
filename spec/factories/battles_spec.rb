require 'rails_helper'

RSpec.describe "Battle Factory", type: :factory do
  it "creates a battle with two fighters" do
    battle = create(:battle)

    expect(battle.fighters.size).to eq(2)
    expect(battle.fighters.first.character).to be_present
    expect(battle.fighters.second.character).to be_present
  end

  it "creates a battle with a winner" do
    battle = create(:battle, winner_index: 0)

    expect(battle.fighters.size).to eq(2)
    expect(battle.fighters[0].winner).to be true
    expect(battle.fighters[1].winner).to be false
  end

  it "creates a battle with more than two fighters" do
    battle = create(:battle, fighter_count: 4)

    expect(battle.fighters.size).to eq(4)
    battle.fighters.each do |fighter|
      expect(fighter.character).to be_present
    end
  end
end