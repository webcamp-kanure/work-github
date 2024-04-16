class Item < ApplicationRecord
  # has_one_attached :item_image
  has_one_attached :image
  

  belongs_to :cart_item
  belongs_to :genre
  has_many :order_details, dependent: :destroy

end
