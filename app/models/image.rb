require 'open-uri'
require 'json'

class Image
	def initialize(options = {})
		@location = options[:location] || 'Washington DC'
		@CLIENT_ID = '1fd38795363d4d3ea1889a73bb073d0a'
		@CLIENT_SECRET = '113832cde77a49ec91657f8f716a6236'
		#@ACCESS_TOKEN = '1602344324.1fb234f.5a9b17863e9f4642a2edab6f6126e566'
		@ACCESS_TOKEN = '1602344324.1fd3879.532a2134461846b2b36afe023407807a'
	end

	def example
		@json = "https://api.instagram.com/v1/tags/nofilter/media/recent?client_id=#{@CLIENT_ID}"
	end


	def get_images
		parse_instagram(@location)
		
		@array = []
		@children = @json["data"].count

		@children.times do |child|
			@array << @json["data"][child]["images"]["standard_resolution"]["url"]
			#@array << @json["data"][child]["link"]
		end

		@array
	end

	def parse_instagram(location)
		@search = Location::GoogleAPI.new
		@location_data = @search.set_location(location)
		puts @location_data
		@link = "https://api.instagram.com/v1/media/search?lat=#{@location_data[:lat]}&lng=#{@location_data[:lng]}&access_token=#{@ACCESS_TOKEN}"
		puts @link
		@data = open(@link).read
		@json = JSON.parse(@data)
	end

	def link_option
		@link = "https://api.instagram.com/v1/media/popular?access_token=#{@ACCESS_TOKEN}"

	end

end	

