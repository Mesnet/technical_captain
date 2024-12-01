# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Define characters with their attributes and image files
characters = [
  { name: "Pika", attack_points: 84, health: 60, precision: 56, avatar_path: 'db/seeds/images/pika-min.png' },
  { name: "Salam", attack_points: 72, health: 55, precision: 64, avatar_path: 'db/seeds/images/salam-min.png' },
  { name: "Carap", attack_points: 68, health: 70, precision: 60, avatar_path: 'db/seeds/images/carap-min.png' }
]

# Define weapons with their attributes and image files
weapons = [
  { name: "Brow", health: 0, attack_points: 0, precision: 10, icon_path: 'db/seeds/images/brow-min.png' },
  { name: "Shield", health: 20, attack_points: 0, precision: 0, icon_path: 'db/seeds/images/shield-min.png' }
]

# Create characters
characters.each do |char|
  Character.create!(
    name: char[:name],
    attack_points: char[:attack_points],
    health: char[:health],
    precision: char[:precision],
    avatar: { io: File.open(Rails.root.join(char[:avatar_path])), filename: File.basename(char[:avatar_path]), content_type: 'image/png' }
  )
end

# Create weapons
weapons.each do |weapon|
  Weapon.create!(
    name: weapon[:name],
    health: weapon[:health],
    attack_points: weapon[:attack_points],
    precision: weapon[:precision],
    icon: { io: File.open(Rails.root.join(weapon[:icon_path])), filename: File.basename(weapon[:icon_path]), content_type: 'image/png' }
  )
end
