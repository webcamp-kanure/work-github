class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  
  def top
    @orders = Oder.all
  end
  
end
