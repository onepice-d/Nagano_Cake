class Admin::GenresController < ApplicationController
	def index
		@genres = Genre.all
		@genre = Genre.new
	end

	def create
	end

	def edit
	end

	def update
	end

end
