class Admin::HomesController < ApplicationController
	def top
		@genres = Genre.all
	end
end
