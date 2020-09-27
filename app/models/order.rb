class Order < ApplicationRecord
	enum payment_method: {銀行:0, クレジットカード:1}
	enum selected_addres: {}
end
