class OrderItem < ApplicationRecord

	belongs_to :item, dependent: :destroy
	belongs_to :order,dependent: :destroy
	enum status: [:着手不可,:製作待ち,:製作中,:製作完了]

end

