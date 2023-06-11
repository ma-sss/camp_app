class Api::V1::Users::RegistrationsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def create
        user = User.new(registration_params)
    
        if user.save
          render json: user, status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
    end

    private

    def registration_params
        params.require(:registration).permit(:name, :email, :password, :password_confirmation)
    end
    
end
