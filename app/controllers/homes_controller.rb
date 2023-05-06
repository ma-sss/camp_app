class HomesController < ApplicationController
  def top
      @admins = Admin.all
      @favorite = Favorite.new
  end
end
