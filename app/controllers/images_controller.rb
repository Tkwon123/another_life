class ImagesController < ApplicationController

	def index
		@image = Image.new(location: params[:location])
		@images = @image.get_images
		@count = @images.count
		@params = params[:location]
	end


end
