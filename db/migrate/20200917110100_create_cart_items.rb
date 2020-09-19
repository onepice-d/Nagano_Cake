class CreateCartItems < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_items do |t|
      t.integer :amount
      t.integer :customer_id
      t.integer :item_id

      t.timestamps
    end
  end
end
