class Item < ApplicationRecord

  has_one_attached :image

  has_many :cart_items
  # belongs_to :cart_item
  belongs_to :genre
  has_many :order_details, dependent: :destroy

  def get_image
    if image.attached?
      image.variant(resize_to_fill: [100, 100])
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
end
