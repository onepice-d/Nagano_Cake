class Admin::OrdersController < ApplicationController

	def index
		@customer = Customer.find(params[:id])
		@orders = @customer.orders
	end

	def create
	end

	def show
	end

	def update
	end


end
