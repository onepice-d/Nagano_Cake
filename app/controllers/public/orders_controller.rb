class Public::OrdersController < ApplicationController
	def new
		@order = Order.new
	end

	def create
		if current_customer.cart_items.exists?
      	@order = Order.new(order_params)
      	@order.customer_id = current_customer.id

      	# 住所のラジオボタン選択に応じて引数を調整
      	 @add = params[:order][:add].to_i
      	 case @add
        when 1
          @order.post_code = @customer.post_code
          @order.address = @customer.address
          @order.name = full_name(@customer)
        when 2
          @order.postalcode = params[:order][:postal_code]
          @order.address = params[:order][:address]
          @order.name = params[:order][:name]
        when 3
          @order.postal_code = params[:order][:postal_code]
          @order.address = params[:order][:address]
          @order.name = params[:order][:name]
      end
      @order.save

      # send_to_addressで住所モデル検索、該当データなければ新規作成
      if Delivery.find_by(address: @address).nil?
        @delivery = Delivery.new
        @delivery.post_code = @order.postal_code
        @delivery.address = @order.address
        @delivery.name = @order.name
        @delivery.customer_id = current_customer.id
        @delivery.save
      end

      	# cart_itemsの内容をorder_itemsに新規登録
      current_customer.cart_items.each do |cart_item|
        order_item = @order.order_items.build
        order_item.order_id = @order.id
        order_item.item_id = cart_item.item_id
        order_item.amount = cart_item.quantity
        order_item.price = cart_item.item.price
        order_item.save
        cart_item.destroy #order_itemに情報を移したらcart_itemは消去
      end
      render :thanks
    else
      redirect_to public_items_path
　　　flash[:danger] = 'カートが空です。'
    end
  end

	end

	def confirm
	end

	def thanks
	end

	def index
    @orders = @customer.orders
	end

  def show
    @order = Order.find(params[:id])
    if @order.customer_id != current_customer.id
      redirect_back(fallback_location: root_path)
      flash[:alert] = "アクセスに失敗しました。"
  end

  private
  def set_customer
    @customer = current_customer
  end


  def order_params
    params.require(:order).permit(
      :created_at, :postal_code, :address, :status, :payment_method, :postal_code, :shipping_cost, :name,
      order_items_attributes: [:order_id, :item_id, :quantity, :order_price, :make_status]
      )
  end

end
