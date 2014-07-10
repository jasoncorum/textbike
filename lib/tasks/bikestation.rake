require 'twilio-ruby'

namespace :bikestations do
	desc "Rake task to check for bikes at bikestations"
	task :fetch => :environment do

		commutes = Commute.all
		commutes_check = []
		commutes_check_empty_stations = []
		phone_to_text = []
		
		t = Time.now.strftime("%H:%M")
		t2 = t.split(":")
		t3 = t2[0].to_i * 60 + t2[1].to_i

		account_sid = 'AC5d5c74ae6481d909640a6b40c3201ea1'
		auth_token = '8b332b644216c752422a8af43b058778'

		commutes.each do |commute|
			y = commute.commute.strftime('%H:%M')
			y2 = y.split(":")
			y3 = y2[0].to_i * 60 + y2[1].to_i

			if y3 > t3 && y3 < t3 + 10
				commutes_check << commute
			end
		end

		commutes_check.each do |c|
		end
		
		Commute.get_stations.each do |x| #For some reason all stations displaying as having no bikes.
  		if x['nbBikes'] == "0"
  			commutes_check_empty_stations << x['name']
  		end
		end
	
		commutes_check.each do |commute|  
			if commutes_check_empty_stations.include?("#{commute.station_name}") 
				phone_to_text << commute.user.phone 
			end
		end

		phone_to_text.each do |phone|
			@client = Twilio::REST::Client.new account_sid, auth_token
			message = @client.account.messages.create(:body => "Ruh roh! Your bikestation has no bikes.",
			:to => "+1#{phone}",     # Replace with your phone number
			:from => "+12027592647")   # Twilio number
			@message = message.sid
		end

	end
end