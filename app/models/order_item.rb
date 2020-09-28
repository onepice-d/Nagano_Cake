class OrderItem < ApplicationRecord

	belongs_to :item, dependent: :destroy
	belongs_to :order,dependent: :destroy

	enum making_status: {"着手不可":0,"製作待ち":1,"製作中":2,"製作完了":3}

end

