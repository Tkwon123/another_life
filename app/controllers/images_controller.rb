class ImagesController < ApplicationController

	def index
		@image = Image.new(location: params[:location])
		@images = @image.get_images
		@params = params[:location]
	end


end
