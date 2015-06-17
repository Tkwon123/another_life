require 'open-uri'
require 'json'

class Image
	def initialize(options = {})
		@location = options[:location] || 'Washington DC'
		@CLIENT_ID 	=  Rails.application.secrets.CLIENT_ID
		@CLIENT_SECRET = Rails.application.secrets.CLIENT_SECRET
		#@ACCESS_TOKEN = '1602344324.1fb234f.5a9b17863e9f4642a2edab6f6126e566'
		@ACCESS_TOKEN = Rails.application.secrets.ACCESS_TOKEN
	end

	def example
		@json = "https://api.instagram.com/v1/tags/nofilter/media/recent?client_id=#{@CLIENT_ID}"
	end


	def get_images
		parse_instagram(@location)
		
		@array = []
		@children = @json["data"].count

		@children.times do |child|
			@array << [@json["data"][child]["images"]["standard_resolution"]["url"], @json["data"][child]["link"], @json["data"][child]["caption"]]
			#@array << @json["data"][child]["link"]@children.times do |child|
		end

		@array
	end

	def parse_instagram(location)
		@search = Location::GoogleAPI.new
		@location_data = @search.set_location(location)
		@link = "https://api.instagram.com/v1/media/search?lat=#{@location_data[:lat]}&lng=#{@location_data[:lng]}&access_token=#{@ACCESS_TOKEN}"
		@data = open(@link).read
		@json = JSON.parse(@data)
	end

	def link_option
		@link = "https://api.instagram.com/v1/media/popular?access_token=#{@ACCESS_TOKEN}"

	end

end	

