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

  def destroy
    reservation = Reservation.find(params[:id])
    admin = Admin.find_by(id: params[:admin_id])
    user = User.find_by(id: current_api_v1_user.id)
    UserMailer.with(user: user, reservation: reservation, admin: admin).cancel_for_user_email.deliver_later
    AdminMailer.with(user: user, reservation: reservation, admin: admin).cancel_for_admin_email.deliver_later
    if reservation.destroy
        flash[:notice] = "予約のキャンセルが完了しました"
        render json: reservation
    end
  end

  private

  def reservation_params
      params.require(:reservation).permit(:day, :start_time, :admin_id)
  end
end