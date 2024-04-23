class Public::GenresController < ApplicationController

  def genre_search
    @genre_id = params[:id]
    @genre = Genre.find(params[:id])
    items = Item.where(genre_id: @genre_id)
    @items = items.page(params[:page])
    @genres = Genre.all
    render template: "public/items/index"
  end

end
