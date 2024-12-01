FactoryBot.define do
  factory :fighter do
    association :battle
    association :character
    winner { false } # Default to not being a winner

    trait :winner do
      winner { true }
    end
  end
end
