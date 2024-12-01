FactoryBot.define do
  factory :battle do
    transient do
      fighter_count { 2 } # Default to 2 fighters
      winner_index { nil } # Specify a winner (index of the fighter)
    end

    after(:build) do |battle, evaluator|
      # Create characters for fighters
      characters = create_list(:character, evaluator.fighter_count)

      # Build fighters and associate them with the battle
      characters.each_with_index do |character, index|
        battle.fighters.build(
          character: character,
          winner: (index == evaluator.winner_index)
        )
      end
    end
  end
end
