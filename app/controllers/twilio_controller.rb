# require 'twilio-ruby'
 
# class TwilioController < ApplicationController
#   include Webhookable
 
#   after_filter :set_header
#   skip_before_action :verify_authenticity_token
#   before_action :set_account_credentials, only [:sms]
 
#   def voice
#     response = Twilio::TwiML::Response.new do |r|
#       r.Say 'Hey there. Congrats on integrating Twilio into your Rails 4 app.', :voice => 'alice'
#       r.Play 'http://linode.rabasa.com/cantina.mp3'
#       end
#     render_twiml response
#   end

#   def sms
#     @user_phone = {}
    
#     @user_phone.each do |key, value|
#     client.account.messages.create(
#     :from => @from,
#     :to => key,
#     :body => "Hey #{value}, There are no bikes left at your station!") 
#     puts "Sent message to #{value}"
#     end
#   end

# end
