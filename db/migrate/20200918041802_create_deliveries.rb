class CreateDeliveries < ActiveRecord::Migration[5.2]
  def change
    create_table :deliveries do |t|
    	t.integer :customer_id
    	t.string :name
    	t.string :postal_code
    	t.string :address

      t.timestamps
    end
  end
end
