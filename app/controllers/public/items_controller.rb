class Public::ItemsController < ApplicationController

  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
    @taxed_price = (@item.price + @item.price * 0.1).round
    @cart_item_new = CartItem.new
  end


end
