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
    validates :postal_code
    validates :address
    validates :telephone_number
    validates :email
  end

  validates :password, presence: true, on: :update!
  validates :postal_code, length: { is: 7 }, numericality: { only_integer: true }
  validates :telephone_number, length: { in: 10..11 }, numericality: { only_integer: true }

  def self.looks(search, word)
    if search == "perfect_match"
      @customer = Customer.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      @customer = Customer.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @customer = Customer.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @customer = Customer.where("name LIKE?","%#{word}%")
    else
      @customer = Customer.all
    end
  end
  
end
