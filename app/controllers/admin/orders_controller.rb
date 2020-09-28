class Admin::OrdersController < ApplicationController
	before_action :authenticate_admin!

	def index
  	@orders = Order.page(params[:page]).per(10).order('created_at')
  end

	def show
	@order = Order.find(params[:id])
  	@order_items = @order.order_items
  	@total_price = @order_items.sum{|o| o.price * o.amount}
	end

	def update
		@order = Order.find(params[:id]) #注文詳細の特定
  	@order_items = @order.order_items #注文から紐付く商品の取得
  	@order.update(order_params) #注文ステータスの更新
    end
	private
	def order_params
  	params.require(:order).permit(:status)
  end
end




