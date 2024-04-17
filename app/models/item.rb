class Item < ApplicationRecord
  # has_one_attached :item_image
  has_one_attached :image
  
  
  has_many :cart_items
  # belongs_to :cart_item
  belongs_to :genre
  has_many :order_details, dependent: :destroy

attribute :is_sales_status, :boolean

end
