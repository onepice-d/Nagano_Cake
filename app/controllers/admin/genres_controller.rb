class Admin::GenresController < ApplicationController
	def index
		@genres = Genre.all
		@genre = Genre.new
	end

	def create
		@genre = Genre.new(genre_params)
		@genre.save
    	redirect_to admin_genres_path
	end

	def edit
		@genre = Genre.find(params[:id])
	end

	def update
		@genre = Genre.find(params[:id])
		@Genre.update(genre_params)
	end

	private
	def genre_params
		params.require(:genre).permit(:name, :status)
	end
end
