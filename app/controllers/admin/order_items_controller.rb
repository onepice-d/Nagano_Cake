class Admin::OrderItemsController < ApplicationController

	def update
		@order_item = OrderItem.find(params[:id])
		@order_item.update(order_item_params)
	end

	private
      def order_item_params
        params.require(:order_item).permit(:making_status)
      end

end
