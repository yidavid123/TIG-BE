class GtgRulesController < ApplicationController

  def index
      user = User.find(params[:userId])
      payload = {
        gtgs: user.gtgs,
      }
      render json: payload, status: 201
  end

  def show
      gtg = GTG.find(params[:id])
      payload = {
        gtg: gtg,
      }
      render json: payload, status: 201
  end

  def create
      puts params
      puts params[:mods][:userId]

      user = User.find(params[:mods][:userId])

      newGTG = GTG.new(create_params)

      user.gtgs << newGTG

      payload = {
         addGTG: newGTG
      }
      render json: payload, status:201

  end

  def update
      gtg = GTG.find(params[:mods][:group][:id])
      gtg.update(update_params)

      payload = {
         updateGTG: params
      }
      render json: payload, status:201
  end

  def destroy
      puts(params[:id])

      Friend.where(group_id: params[:id]).destroy_all

      Group.destroy(params[:id])


      payload = {
         deleteInfo: params[:id]
      }
      render json: payload, status: 201
  end

  private
  def update_params
    params.require(:mods).require(:group).permit(:id,:name,:location,:price_range)
  end

  private
  def create_params
    params.require(:mods).require(:group).require(:name)
    params.require(:mods).require(:group).permit(:name,:location,:price_range)
  end
end
