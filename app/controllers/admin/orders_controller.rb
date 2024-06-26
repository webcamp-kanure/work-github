class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @orders = Order.page(params[:page]).per(10)
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @customer = @order.customer
    # @item = @order_details
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      flash[:notice] = "注文ステータスを変更しました。"
    end
    @order_details = @order.order_details
    @customer = @order.customer
    render 'admin/orders/show'
  end

  def customer_search
    customer_id = params[:id]
    @customer = Customer.find(params[:id])
    orders = Order.where(customer_id: customer_id)
    @orders = orders.page(params[:page]).per(10)
    render :index
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end


end
