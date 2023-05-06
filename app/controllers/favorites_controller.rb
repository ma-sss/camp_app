class FavoritesController < ApplicationController

    before_action :authenticate_user!

    def index
        @favorites = Favorite.all
        @admins = Admin.all
    end

    def create
        @favorite = Favorite.new(favorite_params)
        if @favorite.save
            redirect_to ''
        else
            flash[:notice] = "失敗しました。"
        end
    end

    def destroy
        favorite = Favorite.find_by(user_id: current_user.id, admin_id: favorite_params[:admin_id])
        favorite.destroy
        redirect_to ''
    end

    private
    def favorite_params
        params.require(:favorite).permit(:user_id, :admin_id)
    end
    
end
