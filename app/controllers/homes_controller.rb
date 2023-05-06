class HomesController < ApplicationController
  def top
      @admins = Admin.all
  end
end
