class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
    	t.integer :customer_id
    	t.string :postal_code
    	t.string :address
    	t.string :name
    	t.integer :shipping_cost
      t.integer :total_price
      t.integer :payment_method
      t.integer :address_number
      t.integer :status, null: :false, limit: 5

      t.timestamps
    end
  end
end
