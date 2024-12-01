# app/services/battles/run_battle_service.rb
class Battles::RunService
  def initialize(battle)
    @battle = battle
  end

  def execute!
    select_winner!
    upgrade_battle_experiences!
    @battle
  end

  private

  def select_winner!
    winner = @battle.fighters.sample
    winner.update!(winner: true)
  end

  def upgrade_battle_experiences!
    @battle.characters.each do |character|
      character.update!(battle_experience: character.battle_experience + 1)
    end
  end
end
