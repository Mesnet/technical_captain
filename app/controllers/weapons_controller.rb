class WeaponsController < ApplicationController
  before_action :set_weapon, only: %i[show edit update destroy]

  def index
    @weapons = Weapon.all
  end

  def show
  end

  def new
    @weapon = Weapon.new
  end

  def create
    @weapon = Weapon.new(weapon_params)
    if @weapon.save
      redirect_to weapons_path, notice: 'Weapon was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @weapon.update(weapon_params)
      redirect_to weapons_path, notice: 'Weapon was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @weapon.destroy
    redirect_to weapons_path, notice: 'Weapon was successfully destroyed.'
  end

  private

  def set_weapon
    @weapon = Weapon.find(params[:id])
  end

  def weapon_params
    params.require(:weapon).permit(:name, :health, :attack_points, :precision, :icon)
  end
end