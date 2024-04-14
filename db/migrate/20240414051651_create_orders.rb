class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :customer_id
      t.integer :total_payment
      t.integer :payment_method
      t.integer :shipping_cost
      t.string :postal_code
      t.text :address
      t.string :name
      t.integer :status

      t.timestamps
    end
  end
end
