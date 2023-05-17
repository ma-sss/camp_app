class AdminsController < ApplicationController

    before_action :authenticate_admin!, only:[:admin_reservations]

    def show
        @admin = Admin.find_by(id: params[:id])
    end

    def admin_reservations
        if params[:day].present?
            if @reservation = Reservation.find_by(day: params[:day])
                @user = User.find_by(id: @reservation.user_id)
            end
        else
            @reservations = Reservation.all
            @users = User.all
        end
    end
    
end
