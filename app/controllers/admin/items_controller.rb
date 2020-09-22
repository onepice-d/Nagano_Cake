class Admin::ItemsController < ApplicationController

	def index
	end

	def new
		@item = Item.new
	end

	def create
		item = Item.new(item_params)
        item.save
        redirect_to items_path
	end

	def show
	end

	def edit
	end

	def update
	end

	private
      def item_paramss
        params.require(:item).permit(:name, :introduction)
      end

end
