class Admin::HomesController < ApplicationController
	before_action :authenticate_admin!
	def top
		@genres = Genre.all
	end
end
