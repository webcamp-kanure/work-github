class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :addresses, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :cart_items, dependent: :destroy

  with_options presence: true do
    validates :last_name
    validates :first_name
    validates :last_name_kana
    validates :first_name_kana
    validates :address
    validates :email
  end

  validates :password, presence: true, on: :update!
  validates :postal_code, presence: true, length: { is: 7 }, numericality: { only_integer: true }
  validates :telephone_number, presence: true, length: { in: 10..11 }, numericality: { only_integer: true }

  def self.looks(search, word)
      @customer = Customer.where("CONCAT(last_name, first_name) LIKE?","%#{word}%")
  end

end
