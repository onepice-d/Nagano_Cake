class Order < ApplicationRecord
	has_many :order_items
	belongs_to :custmor
	enum payment_method: {"銀行":0, "クレジットカード":1}

	enum add: {add:1,add:2,add:3}
   end