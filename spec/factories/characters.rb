FactoryBot.define do
  factory :character do
    name { Faker::Name.unique.name } # Requires 'faker' gem, or replace with a hardcoded name
    health { 60 }
    attack_points { 60 }
    precision { 60 }
  end
end
