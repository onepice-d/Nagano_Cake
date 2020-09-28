class Admin::ItemsController < ApplicationController
	before_action :authenticate_admin!

	def index
		@items = Item.page(params[:page]).per(8)
	end

	def new
		@item = Item.new
		@genres = Genre.all
	end

	def create
		@item = Item.new(item_params)
        if @item.save
         flash[:success] = "登録に成功しました"
        redirect_to admin_item_path(@item.id)
        else
          	flash[:warning] = "入力内容を確認してください"
          render :new
         end
    end

	def show
		@item = Item.find(params[:id])
		@genre = @item.genre
	end

	def edit
		@item = Item.find(params[:id])
	end

	def update
		@item = Item.find(params[:id])
		if @item.update(item_params)
			flash[:success] = "登録に成功しました"
			redirect_to admin_item_path(@item.id)
		else
			flash[:warning] = "入力内容を確認してください"
            render :edit
	     end
	 end

	private
      def item_params
        params.require(:item).permit(:name, :introduction, :price, :is_active, :image, :genre_id)
      end

end
