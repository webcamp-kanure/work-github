class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.admin_id = current_admin.id
    if @item.save
      flash[:notice] = "商品を追加しました。"
      # 詳細ページへ移動するアクション
    else
      @items = Item.new
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
      # 詳細ページへ移動するアクション
    else
      @item = item
      render :edit
    end
  end

end
