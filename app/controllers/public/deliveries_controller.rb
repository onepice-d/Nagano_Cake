class Public::DeliveriesController < ApplicationController
	before_action :authenticate_user!
	before_action :customer_is_deleted

	def index
		@customer = current_customer
        @deliveries = @customer.deliveries
        @delivery = Delivery.new
	end

	def edit
		@delivery = Delivery.find(params[:id])
	end

	def cteate
		@delivery = Delivery.new(delivery_params)
		@delivery.customer_id = current_customer.id
		if @delivery.save
			flash[:success] = "登録に成功しました"
           redirect_to public_delivery_path
           else
            @customer = current_customer
            @deliveries = @customer.delivery.all
            flash[:warning] = "入力内容を確認してください"
            render :index
        end

	end

	def update
		@delivery = Delivery.find(params[:id])

        if @delivery.update(delivery_params)
            redirect_to public_deliveries_path
            flash[:success] =  "更新に成功しました"
        else
            flash[:warning] = "入力内容を確認してください"
            render :edit
        end
	end

	def destroy
		@delivery = Delivery.find(params[:id])
        @delivery.destroy
        flash[:success] = "削除に成功しました"
        redirect_to public_deliveries_path
	end
	
	private
    def delivery_params
        params.require(:delivery).permit(:name, :postal_code, :address, :customer_id)
    end

    def user_is_deleted
      if current_customer.is_deleted?
        redirect_to root_path
      end
    end

end
