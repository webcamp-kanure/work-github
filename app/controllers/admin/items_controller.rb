class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @items = Item.page(params[:page]).per(10)
  end

  def new
    @item = Item.new
  end



  def create
    @item = Item.new(item_params)
    @item.admin_id = current_admin.id
    @item.is_active = params[:item][:is_active] == 'true'  # 販売ステータスを設定
    if @item.save
      flash[:notice] = "商品を追加しました。"
      redirect_to admin_item_path(@item)
    else
      # @items = Item.new
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    if item.update(item_params)
      flash[:notice] = "商品情報を変更しました。"
      @item = item
      render :show
    else
      @item = item
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :introduction, :price, :is_active, :genre_id, :image)
  end


end
