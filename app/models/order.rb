class Order < ApplicationRecord
	enum payment_method: {銀行振り込み:0, クレジットカード:1}
end
