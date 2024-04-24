class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy

  has_many :order_details
  has_many :items, through: :order_details

  with_options presence: true do
    validates :payment_method
    validates :address
    validates :name
  end

  validates :postal_code, length: { is: 7 }, numericality: { only_integer: true }


  enum status: {
    "入金待ち":0,
    "入金確認":1,
    "製作中":2,
    "発送準備中":3,
    "発送済み":4
  }

  enum payment_method: {
    "クレジットカード": 0,
    "銀行振込": 1
  }

end
