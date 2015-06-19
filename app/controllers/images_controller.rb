class ImagesController < ApplicationController

	def index
		@last_time = Time.now.to_i if @last_time.nil?
	end

	def image
		@image = Image.new(location: params[:location], last_time: params[:page])
		@images, @last_time = @image.get_images
		@count = @images.count
		@location = params[:location]
	end

end

