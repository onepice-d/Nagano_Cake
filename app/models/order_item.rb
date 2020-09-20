class OrderItem < ApplicationRecord
	belongs_to :items, dependent: :destroy
end
