# app/services/battles/run_battle_service.rb
class Battles::RunBattleService
  def initialize(battle)
    @battle = battle
  end

  def execute!
    winner = @battle.fighters.sample
    winner.update!(winner: true)
  end
end
