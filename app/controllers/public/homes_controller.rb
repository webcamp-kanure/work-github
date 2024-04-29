class Public::HomesController < ApplicationController

  def top
    @items = Item.all.order("created_at DESC")
    @genres = Genre.all
  end

  def about
  end

end
