json.extract! @battle, :id, :created_at, :updated_at
json.url battle_url(@battle, format: :json)

json.fighters @battle.fighters do |fighter|
  json.partial! "fighters/fighter", fighter: fighter
end