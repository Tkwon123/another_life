class ImagesController < ApplicationController

	def index
		@image = Image.new
		@images = @image.get_images
	end


end
