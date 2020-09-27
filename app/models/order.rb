class Order < ApplicationRecord

	enum payment_method: {銀行:0, クレジットカード:1}

	enum selected_addres: {ご自身の住所:1,address:2,new_address:3}
   end