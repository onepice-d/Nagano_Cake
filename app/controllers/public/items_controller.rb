class Public::ItemsController < ApplicationController
	def index
		@items = Item.all
		@genres = Genre.all
	end

	def show
		@item = Item.find(params[:id])
		@genre = Genre.find(params[:id])
		@cart = @item.cart_items.build
		@genres = Genre.all
	end

	private
      def item_params
        params.require(:item).permit(:name, :introduction, :price, :is_active, :image, :genre_id)
      end

    end

