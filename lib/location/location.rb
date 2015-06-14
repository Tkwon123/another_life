require 'open-uri'
require 'json'

module Location
	class GoogleAPI
		def initialize
			@root = "https://maps.googleapis.com/maps/api/geocode/json?address="

		end

		def set_location(address)
			@search = address.sub! ' ', '+'
			@request_url = @root + @search
			fetch_data
		end

		def fetch_data
			@data = open(@request_url).read
			@json = JSON.parse(@data)
			@location = { 
				formatted_address: @json["results"][0]["formatted_address"],
				lat:  @json["results"][0]["geometry"]["location"]["lat"],
				lng:  @json["results"][0]["geometry"]["location"]["lng"]
			}
		end


	end
end
