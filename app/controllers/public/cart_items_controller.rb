class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart_items = current_customer.cart_items.all
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id=current_customer.id
    @cart_items=current_customer.cart_items.all
      @cart_items.each do |cart_item|
        if cart_item.item_id==@cart_item.item_id
        new_amount = cart_item.amount + @cart_item.amount
        cart_item.update_attribute(:amount, new_amount)
        @cart_item.delete
        end
      end

    @cart_item.save
    redirect_to cart_items_path,notice:"カートに商品が入りました"
  end

  def update
    cart_item = current_customer.cart_items.find(params[:id])
    cart_item.update(cart_item_params)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    cart_item = current_customer.cart_items.find(params[:id])
    if cart_item.destroy
      flash[:notice] = 'カート内の商品が削除されました'
    else
      flash[:alert] = '削除に失敗しました'
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_back(fallback_location: root_path)
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end

end
