class ImagesController < ApplicationController

	def index
	end

	def image
		@image = Image.new(location: params[:location], last_time: params[:page])
		@images, @last_time = @image.get_images
		@count = @images.count
		@last_image = params[:page]
	end

end

