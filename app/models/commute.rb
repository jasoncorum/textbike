class Commute < ActiveRecord::Base

	belongs_to :user, inverse_of: :commutes

	def self.get_stations
		get_cap_stations = RestClient.get 'http://www.capitalbikeshare.com/data/stations/bikeStations.xml'
		returned_stations = Hash.from_xml(get_cap_stations)
		returned_stations["stations"]["station"]
	end

	def self.get_station_name
		@station_names = []
		Commute.get_stations.each do |x|
		@station_names << x['name']
		end
	end

	def find_commutes_no_bikes
		commutes = Commute.all
		commutes_check = []
		commutes_check_empty_stations = []
		@phone_to_text = []

		commutes.each do |commute|
			y = commute.commute.strftime('%H:%M')
			y2 = y.split(":")
			y3 = y2[0].to_i * 60 + y2[1].to_i

			t = Time.now.strftime("%H:%M")
			t2 = t.split(":")
			t3 = t2[0].to_i * 60 + t2[1].to_i

			if y3 < t3 && y3 > t3 - 6
				commutes_check << commute
			end
		end
		
		Commute.get_stations.each do |x| #For some reason all stations displaying as having no bikes.
      if x['nbBikes'] = 0
        commutes_check_empty_stations << x['name']
      end
		end
	
		commutes_check.each do |commute|  
			if commutes_check_empty_stations.include?("#{commute.station_name}") 
				@phone_to_text << commute.user.phone 
			end
		end
	end

end

# commute = "14:55"
			# hours_minutes = commute.split(":")
			# hours_minutes[0].to_i * 60 + hours_minutes[1]


