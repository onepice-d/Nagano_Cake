class Admin::CustomersController < ApplicationController
	 before_action :authenticate_admin!

	def index
		@customers = Customer.page(params[:page]).per(8)
	end 

	def show
		@customer = Customer.find(params[:id])
	end

	def edit
		@customer = Customer.find(params[:id])
	end

	def update
		@customer = Customer.find(params[:id])
       if @customer.update(customer_params)
        flash[:notice] = "You have updated customer successfully."
        redirect_to admin_customer_path
        else
        flash[:notice] = "errors prohibited this obj from being saved:"
        render :edit
    	end
	end

	private

	def customer_params
		params.require(:customer).permit(:email, :last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :is_deleted)
	end


end
