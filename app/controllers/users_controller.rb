class UsersController < ApplicationController
  before_action only: :show

  def show
      user = User.find(params[:id])
      payload = {
        user: user,
      }
      render json: payload, status: 201
  end

  def create
    user = User.new(user_params)

    if user.save
      token = Knock::AuthToken.new(payload: { sub: user.id }).token
      payload = {
        user: user,
        jwt: token
      }
      render json: payload, status: 201
    else
      render json: {errors: user.errors}, status: 422
    end
  end

  def update
      user = User.find(params[:mods][:user][:id])
      user.update(update_params)

      payload = {
         updateUser: params
      }
      render json: payload, status:201
  end

  def destroy
      puts(params[:id])
      User.destroy(params[:id])

      payload = {
         deleteInfo: params[:id]
      }
      render json: payload, status: 201
  end

  private
  def user_params
    params.require(:auth).permit(:first_name,:last_name,:email,:address,:phone_number,:password)
  end

  private
  def update_params
    params.require(:mods).require(:user).permit(:id,:first_name,:last_name,:email,:address,:phone_number,:password)
  end

end
