class Item < ApplicationRecord
	has_many :cart_items, dependent: :destroy
	has_many :order_items, dependent: :destroy
	belongs_to :genre, dependent: :destroy
	attachment :image
	validates :name, presence: true
	validates :introduction, presence: true
	validates :price, presence: true
	validates :is_active, presence: true

end
