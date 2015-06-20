class ImagesController < ApplicationController

	def index
		@last_time = Time.now.to_i if @last_time.nil?
		@location = 'washington dc'
	end

	def image
		@location = params[:location]
		@image = Image.new(location: @location, last_time: params[:page])
		@images, @last_time = @image.get_images
		@count = @images.count
	end

	def search
		redirect_to show_image_path(location: (params[:location].blank? ? "Washington DC" : params[:location]) , page: Time.now.to_i)
	end

end

