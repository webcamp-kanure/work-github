class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
  end

  def confirm
    @cart_items = current_customer.cart_items.all
    @order = Order.new(order_params)

    @shipping_cost = 800
    @selected_payment_method = params[:order][:payment_method]

    # 商品合計額の計算
    @cart_items_price = 0
    @cart_items.each do |cart_item|
      @cart_items_price += cart_item.item.price*cart_item.amount
    end

    # 支払額
    @total_payment = @shipping_cost + @cart_items_price

    # 配送先住所
    @selected_address = current_customer.postal_code + " " + current_customer.address + " " + current_customer.last_name + current_customer.first_name

  end

  def thanks
  end

  def create
    @order = Order.new(order_params)



    if @order.save
      cart_items = CartItem.where(customer_id: current_customer.id)
      cart_items.each do |cart_item|
        order_detail = OrderDetail.new
        order_detail.item_id = cart_item.item_id
        order_detail.order_id = @order.id
        order_detail.amount = cart_item.amount
        order_detail.price = cart_item.item.with_tax_price
        order_detail.making_status = 0
        if order_detail.save
          cart_items.destroy_all
        end
      end
      redirect_to thanks_order_path
    else

    byebug
      @order = Order.new
      render :new
    end
  end

  def index
    @orders = Order.where(customer_id: current_customer.id).order(created_at: :desc)
  end

  def show
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: @order.id)
  end


  private

  def order_params
  params.require(:order).permit(:shipping_cost, :payment_method, :name, :address, :postal_code, :customer_id, :total_payment, :status)
  end

end
