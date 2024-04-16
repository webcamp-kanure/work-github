class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
  end

  def confirm
    @cart_items = CartItem.where(customer_id: current_member.id)
    @shipping_cost = 800
    @selected_pay_method = params[:order][:payment_method]

    # 商品合計額の計算
    @cart_items_price = []
    @cart_items.each do |cart_item|
      cart_items_price << cart_item.item.price*cart_item.amount
    end

    # 支払額
    @total_payment = @shipping_cost + @cart_items_price

    # 配送先住所
    @selected_address = current_customer.postal_code + " " + current_customer.address + " " + current_customer.family_name + current_customer.first_name
  end

  def thanks
  end

  def create
    @order = Order.new

    @order.customer_id = current_customer.id
    @order.shipping_cost = 800
    @cart_items = CartItem.where(customer_id: current_customer.id)

    # 商品合計額の計算
    @cart_items_price = []
    @cart_items.each do |cart_item|
      cart_items_price << cart_item.item.price*cart_item.amount
    end

    # 支払額
    @order.total_payment = @order.shipping_cost + @cart_items_price

    # 初期注文ステータスの設定
    @order.payment_method = params[:order][:payment_method]
    if @order.payment_method == 0
      @order.status = 1
    else
      @order.status = 0
    end

    # 住所
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.name = current_customer.family_name + current_customer.first_name

    # 注文成功の確認
    if @order.save

      # 成功時、初期製作ステータスの設定
      if @order.status == 0
        @cart_items.each do |cart_item|
          OrderDetail.create!(order_id: @order.id, item_id: cart_item.item.id, price: cart_item.item.price, amount: cart_item.amount, making_status: 0)
        end
      else
        @cart_items.each do |cart_item|
          OrderDetail.create!(order_id: @order.id, item_id: cart_item.item.id, price: cart_item.item.price, amount: cart_item.amount, making_status: 1)
        end
      end

      @cart_items.destroy_all
      redirect_to orders_thanks_path

    # 失敗した際の遷移先
    else
      redirect_to cart_items_path
    end

  end

  def index
    @orders = Order.where(customer_id: current_customer.id).order(created_at: :desc)
  end

  def show
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: @order.id)
  end

end
