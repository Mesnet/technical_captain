FactoryBot.define do
  factory :character do
    name { Faker::Name.unique.name }
    health { 60 }
    attack_points { 60 }
    precision { 60 }

    # Add avatar if you're using ActiveStorage
    after(:build) do |character|
      character.avatar.attach(
        io: File.open(Rails.root.join('spec/fixtures/files/pika.png')),
        filename: 'avatar.png',
        content_type: 'image/png'
      )
    end
  end
end
