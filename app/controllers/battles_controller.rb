class BattlesController < ApplicationController
  # GET /battles or /battles.json
  def index
    @battles = Battle.includes(:winner, fighters: :character).order(created_at: :desc)
  end

  # GET /battles/1 or /battles/1.json
  def show
    @battle = Battle.includes(fighters: :character).find(params[:id])
  end

  # GET /battles/new
  def new
    @battle = Battle.new
    @characters = Character.all
    @weapons = Weapon.all
  end

  # POST /battles or /battles.json
  def create
    service = Battles::CreateService.new(battle_params)
    result = service.execute!

    if result.success?
      Battles::RunService.new(result.battle).execute!
      redirect_to battle_path(result.battle), notice: "Battle was successfully created."
    else
      @characters = Character.all
      @weapons = Weapon.all
      redirect_to new_battle_path, alert: result.error
    end
  end

  private
    # Only allow a list of trusted parameters through.
    def battle_params
      params.require(:battle).permit(:fighters)
    end
end
