class Api::V1::ReservationsController < ApplicationController

  before_action :authenticate_user!

  skip_before_action :verify_authenticity_token

  def create
      admin = Admin.find(params[:admin_id])
      reservation = admin.reservations.build(reservation_params)
      reservation.user_id = current_api_v1_user.id
      

      if reservation.save
        render json: reservation, status: :created
      else
        render json: { errors: reservation.errors.full_messages }, status: :unprocessable_entity
      end
  end

  private

  def reservation_params
      params.require(:reservation).permit(:day, :start_time, :admin_id)
  end
end