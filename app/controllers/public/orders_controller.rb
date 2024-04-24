class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  before_action :check_cart, only: [:new, :confirm, :create]

  def new
    @order = Order.new
    @registered_addresses = Address.where(customer_id: current_customer.id)
  end

  def confirm
    @cart_items = CartItem.where(customer_id: current_customer.id)
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
    @address_type = params[:order][:shipping_address].to_i
    case @address_type
    when 0
      @selected_postal_code = current_customer.postal_code
      @selected_address = current_customer.address
      @selected_name = current_customer.last_name + current_customer.first_name
    when 1
      unless params[:order][:registered_address_id] == ""
        selected = Address.find(params[:order][:registered_address_id])
        @selected_postal_code = selected.postal_code
        @selected_address = selected.address
        @selected_name = selected.name
      else
        redirect_to new_order_path
      end
    when 2
      unless params[:order][:new_postal_code] == "" && params[:order][:new_address] == "" && params[:order][:new_name] == ""
        @selected_postal_code = params[:order][:postal_code]
        @selected_address =  params[:order][:address]
        @selected_name = params[:order][:name]
      else
        redirect_to new_order_path
      end
    end
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

  def check_cart
    unless CartItem.find_by(customer_id: current_customer.id)
      flash[:danger] = "カートに商品がありません"
      redirect_to root_path
    end
  end

end
