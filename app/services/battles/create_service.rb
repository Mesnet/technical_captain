class Battles::CreateService
  def initialize(battle_params)
    @fighters_data = JSON.parse(battle_params[:fighters], symbolize_names: true)
  end

  def execute!
    return failure("A battle requires at least 2 fighters.") if @fighters_data.blank? || @fighters_data.size < 2

    battle = Battle.new

    @fighters_data.each do |fighter_data|
      fighter = build_fighter(fighter_data)
      return failure("Invalid character or fighter data.") unless fighter

      battle.fighters << fighter
    end

    if battle.save
      success(battle)
    else
      failure("There was an issue creating the battle.")
    end
  end

  private

  def build_fighter(fighter_data)
    character = Character.find_by(id: fighter_data[:character_id])
    return nil unless character

    Fighter.new(
      character: character,
      weapon_ids: fighter_data[:weapon_ids] || []
    )
  end

  def success(battle)
    OpenStruct.new(success?: true, battle: battle)
  end

  def failure(error_message)
    OpenStruct.new(success?: false, error: error_message)
  end
end
