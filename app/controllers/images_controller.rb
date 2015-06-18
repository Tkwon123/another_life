class ImagesController < ApplicationController

	def index
		@last_time = 42 #random number to prevent search from erroring out
	end

	def image
		@image = Image.new(location: params[:location], last_time: params[:page])
		@images = @image.get_images
		@count = @images.count
		@last_time = @image.last_image(@images,@count)
		@last_image = params[:page]
	end

end

