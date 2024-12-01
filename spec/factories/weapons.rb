FactoryBot.define do
  factory :weapon do
    name { Faker::Games::Zelda.item } # Example: "Master Sword" (use Faker for fun names)
    health { Faker::Number.between(from: 0, to: 100) }
    attack_points { Faker::Number.between(from: 0, to: 100) }
    precision { Faker::Number.between(from: 0, to: 120) }

    trait :with_icon do
      after(:build) do |weapon|
        weapon.icon.attach(
          io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'icon.png')),
          filename: 'shield.png',
          content_type: 'image/png'
        )
      end
    end
  end
end
