class CartItemsController < ApplicationController
  before_action :authenticate_customer!
  before_action :setup_cart_item!, only: %i[create update destroy]

  def index
    @cart_items = current_cart_item.cart_items.includes([:item])
    @amount = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
  end

  def create
    @cart_item ||= current_cart_item.cart_items.build(item_id: params[:item_id])
    @cart_item.amount += params[:amount].to_i
    if  @cart_item.save
      flash[:notice] = '商品が追加されました。'
      redirect_to cart_items_path
    else
      flash[:alert] = '商品の追加に失敗しました。'
      redirect_to item_url(params[:item_id])
    end
  end

  def update
    if @cart_item.update(amount: params[:amount].to_i)
      flash[:notice] = '更新されました'
    else
      flash[:alert] = '更新に失敗しました'
    end
    redirect_to cart_items_path
  end

  def destroy
    if @cart_item.destroy
      flash[:notice] = 'カート内の商品が削除されました'
    else
      flash[:alert] = '削除に失敗しました'
    end
    redirect_to cart_items_path
  end

  def destroy_all
    CartItem.destroy_all
    current_customer.cart_item.destroy_all
    redirect_to cart_items_path, notice: 'カートが空になりました。'
  end

  private

  def setup_cart_item!
    @cart_item = current_cart_item.cart_items.find_by(item_id: params[:item_id])
  end

end
