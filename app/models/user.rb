class User < ActiveRecord::Base

	has_many :commutes, inverse_of: :user

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


	def self.update
		
	# User where commute time is in 5 min. Find all bikestations that correspond to that user. Check the api for bikes at bikestation. If no bikes send text.

	@commute_check = user.commutes.find_each(commute: commute < Time.now)

	@users_find = Users.commutes.find

	# 	@bikestation_update = Bikestation.where('commute < ?', (Time.now - 5))
		
	# 	@bikestation_update_id = @bikestation_update.pluck(:user_id)

	# 	@bikestation_update_phone = []

	# 	@bikestation_update_id.each do |x|
	# 		User.find(x)
	# 		@bikestation_update_phone << User.phone
	# 	end
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
