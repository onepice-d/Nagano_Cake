class Order < ApplicationRecord
	has_many :order_items
	belongs_to :customer
	enum payment_method: {"銀行振込":0, "クレジットカード":1}


	enum status: {"入金待ち":0, "入金確認":1, "製作中":2, "発送準備中":3, "発送中":4}

		# 個数小計
	def total_count
		total = 0
		order_items.each do |order_item|
			total += order_item.amount
		end
		total
	end

   end