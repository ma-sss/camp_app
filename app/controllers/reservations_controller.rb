class ReservationsController < ApplicationController
    before_action :authenticate_user!, only:[:new, :create, :show]

    def index
        @admin = Admin.find_by(id: params[:admin_id])
        @reservations = @admin.reservations.where("day >= ?", Date.current).where("day < ?", Date.current >> 3).order(day: :desc)
    end

    def new
        @reservation = Reservation.new
        admin = Admin.find_by(id: params[:admin_id])
        @reservation.admin_id = admin.id
        @day = params[:day]
        @start_time = DateTime.parse(@day + " " + "JST")
    end
    
    def show
        @admin = Admin.find_by(id: params[:admin_id])
        @reservation = Reservation.find(params[:id])
    end
    
    def create
        @reservation = Reservation.new(reservation_params)
        @admin = Admin.find_by(id: params[:admin_id])
        @reservation.admin_id = @admin.id
        @user = User.find_by(id: current_user.id)
        if @reservation.save
            flash[:notice] = "予約が完了しました"
            UserMailer.with(user: @user, reservation: @reservation, admin: @admin).success_for_user_email.deliver_later
            AdminMailer.with(user: @user, reservation: @reservation, admin: @admin).success_for_admin_email.deliver_later
            redirect_to admin_reservation_path(@admin.id, @reservation.id)
        else
            flash[:alert] = @reservation.errors.full_messages.join(', ')
            render :new
        end
    end

    def destroy
        @reservation = Reservation.find(params[:id])
        @admin = Admin.find_by(id: params[:admin_id])
        @user = User.find_by(id: current_user.id)
        UserMailer.with(user: @user, reservation: @reservation, admin: @admin).cancel_for_user_email.deliver_later
        AdminMailer.with(user: @user, reservation: @reservation, admin: @admin).cancel_for_admin_email.deliver_later
        if @reservation.destroy
            flash[:notice] = "予約のキャンセルが完了しました"
            redirect_to reservations_user_reservations_path
        end
    end

    def user_reservations
        @reservations = Reservation.where(user_id: current_user.id)
        @admins = Admin.all
    end

    private
    def reservation_params
        params.require(:reservation).permit(:day, :user_id, :start_time, :admin_id)
    end
end
