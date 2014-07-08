class Bikestation < ActiveRecord::Base

	belongs_to :user

	def self.get_stations
		get_cap_stations = RestClient.get 'http://www.capitalbikeshare.com/data/stations/bikeStations.xml'
		returned_stations = Hash.from_xml(get_cap_stations)
		returned_stations["stations"]["station"]
	end

	def self.get_station_name
		@station_names = []
		Bikestation.get_stations.each do |x|
		@station_names << x['name']
		end
	end

	def self.update
		@bikestation_update = Bikestation.where('commute < ?', Time.now)
		@bikestation_update_id = @bikestation_update.pluck(:user_id)

		@bikestation_update_phone = []

		@bikestation_udate_id.each do |x|
			User.find(x)
			@bikestation_update_phone << User.phone
		end
	end


	# def self.update
	# 	@bikestation_update = Bikestation.where('commute < ?', Time.now)
 #      Bikestation.get_stations.each do |x|
 #      if @bikestation_update.station_name == x['name']
 #      @bikestation_update.nb_bikes = y['nbBikes']
 #      end
 #    end
 #  end 

	# def self.update
	# 	@bikestation_update = Bikestation.where('commute > ?', Time.now)
	# 	@bikestation_update.each do |x|
	# 		if x.commute - Time.now < 1000000000 && x.commute - Time.now >= 1
 #    		Bikestation.get_stations.each do |y|
 #      		if x.station_name == y['name']
 #        		x.nb_bikes = y['nbBikes']
 #      		end
 #      	end
	# 		end
	# 	end
	# end

end


