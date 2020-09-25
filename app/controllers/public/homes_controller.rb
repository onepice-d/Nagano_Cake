class Public::HomesController < ApplicationController
	def top
		@genres = Genre.all
	end

	def about
	end

	  private

  def homes_params
    params.require(:genre).permit(:name)
  end

end
