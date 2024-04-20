class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @orders = Order.all
  end

def show
  @order = Order.find(params[:id])
  @order_details = OrderDetail.where(order_id: @order.id).all
  @items = @order_detail.items.all
  @non_taxed_price = @order_detail.price - 800
end

  def update
    order = Order.find(params[:id])
    if order.update(order_params)
      flash[:notice] = "注文ステータスを変更しました。"
    end
      @order = order
      render :show
  end

end
