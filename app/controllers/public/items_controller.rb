class Public::ItemsController < ApplicationController
	def index
		@items = Item.all
		@genres = Genre.all
	end

	def show
		@item = Item.find(params[:id])
		@genre = Genre.find(params[:id])
		@cart_item = CartItem.new(item_id: @item.id)
	end

	private
      def item_params
        params.require(:item).permit(:name, :introduction, :price, :is_active, :image, :genre_id)
      end

    end

