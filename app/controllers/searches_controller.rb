class SearchesController < ApplicationController

  def search
    @range = params[:range]

    if @range == "会員"
      customers = Customer.looks(params[:search], params[:word])
      @customers = customers.page(params[:page]).per(10)
      render template: "admin/customers/index"
    else
      items = Item.looks(params[:search], params[:word])
      @items = items.page(params[:page]).per(8)
      @items_count = items.count
      if admin_signed_in?
        render template: "admin/items/index"
      else
        @genres = Genre.all
        render template: "public/items/index"
      end
    end
  end

end
