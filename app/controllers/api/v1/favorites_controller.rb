class Api::V1::FavoritesController < ApplicationController

    before_action :authenticate_user!
  
    skip_before_action :verify_authenticity_token

    def index
        favorites = Favorite.where(user_id: current_api_v1_user.id)
        render json: favorites
    end
  
    def create
        favorite = Favorite.new(favorite_params)
        favorite.user_id = current_api_v1_user.id
        if favorite.save
            render json: favorite
        else
            render json: favorite.erros, status: 422
        end
    end

    def destroy
        favorite = Favorite.find_by(user_id: current_api_v1_user.id, admin_id: params[:id])
        favorite.destroy
        render json: favorite
    end
  
    private
  
    def favorite_params
        params.require(:favorite).permit(:admin_id)
    end
  end