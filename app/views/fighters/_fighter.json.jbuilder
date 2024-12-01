json.extract! fighter, :id, :winner

json.character do
  json.partial! "characters/character", character: fighter.character
end