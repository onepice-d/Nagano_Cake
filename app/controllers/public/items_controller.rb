class Public::ItemsController < ApplicationController
	def index
		@items = Item.page(params[:page]).per(8)
		if params[:sort]
			@items = Item.where(genre_id: params[:sort])
		end
		@genres = Genre.all
	end

	def show
		@item = Item.find(params[:id])
		@genre = Genre.where(genre_id: params[:status])
		@cart_item = CartItem.new(item_id: @item.id)
		@genres = Genre.all

	end

	private
      def item_params
        params.require(:item).permit(:name, :introduction, :price, :is_active, :image, :genre_id)
      end

    end

