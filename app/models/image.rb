require 'open-uri'
require 'json'

class Image
	def initialize(options = {})
		@location = options[:location] || 'Washington DC'
		@last_time = options[:last_time]
		@CLIENT_ID 	=  Rails.application.secrets.CLIENT_ID
		@CLIENT_SECRET = Rails.application.secrets.CLIENT_SECRET
		#@ACCESS_TOKEN = '1602344324.1fb234f.5a9b17863e9f4642a2edab6f6126e566'
		@ACCESS_TOKEN = Rails.application.secrets.ACCESS_TOKEN
	end

	def example
		@json = "https://api.instagram.com/v1/tags/nofilter/media/recent?client_id=#{@CLIENT_ID}"
	end


	def get_images
		parse_instagram(@location, @last_time)
		@array = []
		@children = @json["data"].count - 1

		@children.times do |child|
			@array << [
			@json["data"][child]["images"]["standard_resolution"]["url"], 
			@json["data"][child]["link"], 
			@json["data"][child]["caption"],
			@json["data"][child]["created_time"]
		]
		end

		@last_time = @json["data"][@children-1]["created_time"]

		return @array, @last_time
	end

	def parse_instagram(location, last_time)
		@last_time = last_time.to_i - 60
		@search = Location::GoogleAPI.new	
		@location_data = @search.set_location(location)
		@link = "https://api.instagram.com/v1/media/search?lat=#{@location_data[:lat]}&lng=#{@location_data[:lng]}&max_timestamp=#{@last_time}&access_token=#{@ACCESS_TOKEN}"
		@data = open(@link).read
		@json = JSON.parse(@data)

	end


	def last_image(array,max)
		#last element in the image array, third element in the envelope
		@last_time = array[max-1][2]["created_time"]
	end

end	
