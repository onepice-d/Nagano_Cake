class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
   before_action :set_customer


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
  @order_item.price = (cart_item.item.price) #消費税込みに計算して代入
  @order_item.order_id =  @order.id #注文商品に注文idを紐付け
  @order_item.save #注文商品を保存
end #ループ終わり

    current_customer.cart_items.destroy_all #カートの中身を削除
    redirect_to public_orders_thanks_path #thanksに遷移

end

	def confirm
    params[:order][:payment_method] = params[:order][:payment_method].to_i
    @order = Order.new(order_params)
    @deliveries = Delivery.where(customer_id: current_customer)

    @cart_items = current_customer.cart_items
    @order.payment_method = params[:order][:payment_method]
    # 住所のラジオボタン選択に応じて引数を調整
    if params[:order][:address_number] == "1" #address_numberが　”1”　なら下記　ご自身の住所が選ばれたら
      @order.postal_code = current_customer.postal_code #自身の郵便番号をorderの郵便番号に入れる
      @order.address = current_customer.address #自身の住所をorderの住所に入れる
      @order.name = current_customer.last_name+current_customer.first_name #自身の宛名をorderの宛名に入れる

    elsif  params[:order][:address_number] ==  "2" #address_numberが　”2”　なら下記　登録済からの選択が選ばれたら
      @order.postal_code = Delivery.find(params[:order][:delivery]).postal_code #newページで選ばれた配送先住所idから特定して郵便番号の取得代入
      @order.address = Delivery.find(params[:order][:delivery]).address #newページで選ばれた配送先住所idから特定して住所の取得代入
      @order.name = Delivery.find(params[:order][:delivery]).name #newページで選ばれた配送先住所idから特定して宛名の取得代入

    elsif params[:order][:address_number] ==  "3" #address_numberが　”3”　なら下記　新しいお届け先が選ばれたら
      @delivery = Delivery.new()
      @delivery.address = params[:order][:address] #newページで新しいお届け先に入力した住所を取得代入
      @delivery.name = params[:order][:name] #newページで新しいお届け先に入力した宛名を取得代入
      @delivery.postal_code = params[:order][:postal_code] #newページで新しいお届け先に入力した郵便番号を取得代入
      @delivery.customer_id = current_customer.id #newページで新しいお届け先に入力したcustomer_idを取得代入#保存
      @order.postal_code = @delivery.postal_code #上記で代入された郵便番号をorderに代入
      @order.name = @delivery.name #上記で代入された宛名をorderに代入
      @order.address = @delivery.address #上記で代入された住所をorderに代入      
  end
end


	def thanks
	end

	def index
    @orders = Order.where(customer_id: current_customer)
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
      order_items_attributes: [:order_id, :item_id, :amount, :order_price, :make_status]
      )
  end
  def delivery_params
        params.permit(:name, :postal_code, :address, :customer_id)
    end

end