class OrderItem < ApplicationRecord
	belongs_to :item, dependent: :destroy
end
