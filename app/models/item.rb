class Item < ApplicationRecord
  has_one_attached :item_image

  has_many :cart_items
  # belongs_to :cart_item
  belongs_to :genre
  has_many :order_details, dependent: :destroy

  attribute :is_sales_status, :boolean

  def get_item_image
    if item_image.attached?
      item_image.variant(resize_to_fill: [100, 100])
    else
      'no_image.png'
    end
  end

  def with_tax_price
   (price * 1.1).floor
  end

end
