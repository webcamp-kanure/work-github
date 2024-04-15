class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    customer = Customer.find(params[:id])
    if customer.update(customer_params)
      flash[:notice] = "会員情報を変更しました。"
      # 詳細ページへ移動するアクション
    else
      @item = item
      render :edit
    end
  end

end
