class HomesController < ApplicationController
  def top
    binding.pry
      @admins = Admin.all
      @favorite = Favorite.new
  end
end
