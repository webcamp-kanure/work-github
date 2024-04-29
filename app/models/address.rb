class Address < ApplicationRecord

  belongs_to :customer

  with_options presence: true do
    validates :address
    validates :name
  end
  validates :postal_code, presence: true, length: { is: 7 }, numericality: { only_integer: true }
end
