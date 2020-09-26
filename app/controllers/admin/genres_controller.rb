class Admin::GenresController < ApplicationController
	def index
		@genres = Genre.all
		@genre = Genre.new
	end

	def create
		@genre = Genre.new(genre_params)
		if @genre.save
    		redirect_to admin_genres_path
    	else
		    @genres = Genre.all
		    render :index
		end
	end

    def show
      @genre = Genre.find(params[:id])
      @genres = Genre.where(validity: true)
      @items = @genre.items.page(params[:page]).per(9)
    end

	def edit
		@genre = Genre.find(params[:id])
	end

	def update
		@genre = Genre.find(params[:id])
		if @genre.update(genre_params)
			redirect_to admin_genres_path
		else
			render :edit
		end

	end

	private
	def genre_params
		params.require(:genre).permit(:name, :is_active :sort)
	end
end
