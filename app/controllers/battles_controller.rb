class BattlesController < ApplicationController
  before_action :set_battle, only: %i[ show ]

  # GET /battles or /battles.json
  def index
    @battles = Battle.includes(fighters: :character).order(created_at: :desc)
  end

  # GET /battles/1 or /battles/1.json
  def show
  end

  # GET /battles/new
  def new
    @battle = Battle.new
    @characters = Character.all
  end

  # POST /battles or /battles.json
  def create
    @battle = Battle.new(battle_params)

    respond_to do |format|
      if @battle.save
        Battles::RunBattleService.new(@battle).execute!
        format.html { redirect_to battle_url(@battle), notice: "Battle was successfully created." }
        format.json { render :show, status: :created, location: @battle }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @battle.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_battle
      @battle = Battle.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def battle_params
      params.require(:battle).permit(character_ids: [])
    end
end
