class Order < ApplicationRecord
	belongs_to :customer, dependent: :destroy
	has_many :order_items

	enum payment_method: {銀行:0, クレジットカード:1}
	enum selected_addres: {}

end
