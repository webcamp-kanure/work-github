class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!

  def index
    @genres = Genre.all
    @genre = Genre.new
  end

  def create
  @genre = Genre.new(genre_params)
  if @genre.save
    flash[:notice] = "ジャンルを追加しました"
    @genres = Genre.all
    render :index
  else
    @genres = Genre.all
    render :index
  end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    genre = Genre.find(params[:id])
    if genre.update(genre_params)
      flash[:notice] = "ジャンル名を変更しました。"
      @genres = Genre.all
      @genre = Genre.new
      render :index
    else
      @genre = Genre.find(params[:id])
      render :edit
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end


end
