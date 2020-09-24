class Public::CustomersController < ApplicationController
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
        redirect_to public_customer_path
        else
        flash[:notice] = "errors prohibited this obj from being saved:"
        render :edit
    	end
	end

	def check
		@customer = Customer.find(params[:id])
	end

	def withdrow
		@customer = Customer.find(current_customer.id)
    	#現在ログインしているユーザーを@customerに格納
    	@customer.update(is_deleted: "Invalid")
    	#updateで登録情報をにInvalid変更
    	reset_session
    	#sessionIDのresetを行う
    	redirect_to  public_top_path
    	#指定されたrootへのpath
	end

	private

	def customer_params
		params.require(:customer).permit(:email, :last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number)
	end

end
