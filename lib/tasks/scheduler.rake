require 'twilio-ruby'

namespace :bikestations do
	desc "Rake task to check for bikes at bikestations"
	task :fetch => :environment do
	# task :fetch => :production do

		CREDENTIALS = YAML.load_file('../../config/secrets.yml')	
		account_sid = CREDENTIALS['textbike']['account_sid']
		auth_token = CREDENTIALS['textbike']['auth_token']

		commutes = Commute.all
		commutes_check = []
		commutes_check_stations = []
		phone_to_text = []

		t = Time.now.strftime("%H:%M")
		t2 = t.split(":")
		t3 = t2[0].to_i * 60 + t2[1].to_i

		commutes.each do |commute|
			y = commute.commute.strftime('%H:%M')
			y2 = y.split(":")
			y3 = y2[0].to_i * 60 + y2[1].to_i

			if y3 > t3 && y3 <= t3 + 15
				commutes_check << commute
			end
		end

		Commute.get_stations.each do |x| 
			if x['nbBikes'].to_i <= 5
  			hash = {}
  			hash[:name] = x['name']
  			hash[:nbBikes] = x['nbBikes']
  			commutes_check_stations << hash
			end
		end

		commutes_check.each do |x|  
			commutes_check_stations.select { |y| y[:name] == x[:station_name] }
				phone_hash = {}
				phone_hash[:station_name] = x[:station_name] 
 				phone_hash[:phone] = x.user.phone

				phone_to_text << phone_hash
		end

		phone_to_text.each do |x|
			commutes_check_stations.select { |y| if y[:name] == x[:station_name] 
			x[:nb_bikes] = y[:nbBikes] end }
		end

		phone_to_text.each do |phone|

			@client = Twilio::REST::Client.new account_sid, auth_token
			
			if phone[:nb_bikes] > "1"
				message = @client.account.messages.create(:body => "FROM TEXTBIKE: Ruh roh! Your bikestation at #{phone[:station_name]} only has #{phone[:nb_bikes]} bikes.",
					:to => "+1#{phone[:phone]}",     # Replace with user phone number
				:from => "+12027592647")   # Twilio number
				@message = message.sid
			elsif phone[:nb_bikes] == "1"
				message = @client.account.messages.create(:body => "FROM TEXTBIKE: Ruh roh! Your bikestation at #{phone[:station_name]} only has #{phone[:nb_bikes]} bike.",
				:to => "+1#{phone[:phone]}",     # Replace with user phone number
				:from => "+12027592647")   # Twilio number
				@message = message.sid
			else
				message = @client.account.messages.create(:body => "FROM TEXTBIKE: Ruh roh! Your bikestation at #{phone[:station_name]} has no bikes.",
				:to => "+1#{phone[:phone]}",     # Replace with user phone number
				:from => "+12027592647")   # Twilio number
				@message = message.sid
			end
		end
	end
end