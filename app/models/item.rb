class Item < ApplicationRecord
  belongs_to :cart_item
  belongs_to :genre
  has_many :order_details, dependent: :destroy
end
