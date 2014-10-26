require "grouchSMSWeather/version"
require 'open-uri'
require 'json'
require 'clockwork'

module GrouchSMSWeather
  class CLI
    def self.start (args, 
                    grouchSMS = GrouchSMS.new, 
                    shifter = Shifter.new, 
                    weather_service = WeatherService.new, 
                    message_factory = MessageFactory.new, 
                    sms_service = SMSService.new)
      grouchSMS.wanting_weather.each  { |user|
        sms_service.send(
          message_factory.create(
            weather_service.get_weather(
              shifter.shift(user))))
      }
    end
  end

  class GrouchSMS 
    def wanting_weather 
      JSON.parse(open('http://localhost:3000/users/wanting_weather').string)
    end
  end

  class Shifter
    def shift user
      user["latitude"] = 0 - user["latitude"]
      user["longitude"] = 180 + user["longitude"]
      user
    end
  end

  class WeatherService
    def get_weather user
      tempfile = open("https://api.forecast.io/forecast/6f15402c3185b14d36a9249c1c4353a6/#{user['latitude']},#{user['longitude']}") 
      weather = JSON.parse(tempfile.read)
      tempfile.close
      tempfile.unlink
      user[:summary] = weather["currently"]["summary"]
      user[:temperature] = weather["currently"]["temperature"] 
      user
    end
  end

  class MessageFactory
    def create user
      { :message => "It is #{user[:temperature]} degrees and #{user[:summary]}", :to => user["phone"]} 
    end
  end

  class SMSService
    def send message
      api = Clockwork::API.new( '8dc497a757dcadd07faef21f816b67135bd7aef0' )
      message = api.messages.build( :to => message[:to], :content => message[:message])
      response = message.deliver
    end
  end
end
