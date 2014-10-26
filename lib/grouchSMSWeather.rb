require "grouchSMSWeather/version"
require 'open-uri'
require 'json'
require 'clockwork'

module GrouchSMSWeather
  class CLI
    def self.start (args)
      users_json = open('http://localhost:3000/users/wanting_weather')
      users = JSON.parse(users_json.string).each { |user|
        tempfile = open('https://api.forecast.io/forecast/6f15402c3185b14d36a9249c1c4353a6/37.8267,-122.423') 
        weather = JSON.parse(tempfile.read)
        tempfile.close
        tempfile.unlink
        summary = { :summary => weather["currently"]["summary"],
                    :temperature => weather["currently"]["temperature"]}
        api = Clockwork::API.new( '8dc497a757dcadd07faef21f816b67135bd7aef0' )
        message = api.messages.build( :to => user["phone"], :content => summary.to_s)
        response = message.deliver

        if response.success
          puts response.message_id
        else
          puts response.error_code
          puts response.error_description
        end
        puts summary} 
    end
  end
end
