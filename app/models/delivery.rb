class Delivery < ApplicationRecord
	belongs_to :customer

	validates :postal_code
	validates :name, presence: true, length: {maximum: 10, minimum: 2}, uniqueness: true
	validates :address, presence: true
end
