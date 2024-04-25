class Item < ApplicationRecord

  has_one_attached :image

  has_many :cart_items
  # belongs_to :cart_item
  belongs_to :genre
  has_many :order_details, dependent: :destroy

  def get_image
    if image.attached?
      image
      # image.variant(resize_to_fill: [nil, 2000])
      # image.variant(resize_to_fit: [nil, 2000],limit: [2000, 2000])
    else
      'no_image.png'
    end
  end

  def with_tax_price
   (price * 1.1).floor
  end

  with_options presence: true do
    validates :genre_id
    validates :name
    validates :price
  end

  def self.looks(search, word)
    if search == "perfect_match"
      @item = Item.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @item = Item.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @item = Item.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @item = Item.where("title LIKE?","%#{word}%")
    else
      @item = Item.all
    end
  end

  validates :price, numericality: { only_integer: true }
end
