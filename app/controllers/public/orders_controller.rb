class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
	def new
		@order = Order.new(customer_id: current_customer)
    @deliveries = Delivery.where(customer_id: current_customer)
	end

	def create
    @order = Order.new(order_params) #初期化代入
    @order.customer_id = current_customer.id #自身のidを代入
    @order.save #orderに保存
  #order_itmemの保存
  current_customer.cart_items.each do |cart_item| #カートの商品を1つずつ取り出しループ
  @order_item = OrderItem.new #初期化宣言
  @order_item.item_id = cart_item.item_id #商品idを注文商品idに代入
  @order_item.amount = cart_item.amount #商品の個数を注文商品の個数に代入
  @order_item.order_id =  @order.id #注文商品に注文idを紐付け
  @order_item.save #注文商品を保存
end #ループ終わり

    current_customer.cart_items.destroy_all #カートの中身を削除
    redirect_to public_orders_thanks_path #thanksに遷移

end


	def confirm
    params[:order][:payment_method] = params[:order][:payment_method].to_i
    @order = Order.new(order_params)


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