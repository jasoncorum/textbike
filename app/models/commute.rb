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

end