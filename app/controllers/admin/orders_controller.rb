class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @orders = Order.all
  end

def show
  @order = Order.find(params[:id])
  @order_details = @order.order_details
  @customer = @order.customer
  @order = Order.find(params[:id])
  @item = @order.item
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
