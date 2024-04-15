class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def update
    order_detail = OrderDetail.find(params[:id])
    if order_detail.update(order_details_params)
      flash[:notice] = "製作ステータスを変更しました。"
    end
      @order = Order.find(params[:id])
      render :show
  end

end
