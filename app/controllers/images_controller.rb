class ImagesController < ApplicationController

	def index
		@image = Image.new
		@images = @image.get_popular
	end


end
