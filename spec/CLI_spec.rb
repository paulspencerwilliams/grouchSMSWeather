require_relative '../lib/GrouchSMSWeather'

describe GrouchSMSWeather::CLI do
  describe '#start' do
    it 'passes users through components' do
      grouchSMS = double('grouchSMS')
      shifter = double('shifter')
      weather_service = double('weather_service')
      message_factory = double('message_factory')
      sms_service = double('sms_service')
      first_user = double('first_user')
      second_user = double('second_user')
      shifted_first_user = double('shifted_first_user')
      shifted_second_user = double('shifted_second_user')
      first_users_weather = double('first_users_weather')
      second_users_weather = double('second_users_weather')
      first_users_message = double('first_users_message')
      second_users_message = double('second_users_message')
      users = [first_user, second_user]
      
      allow(grouchSMS).to receive(:wanting_weather).and_return(users)
      expect(shifter).to receive(:shift).with(first_user).and_return(shifted_first_user)
      expect(shifter).to receive(:shift).with(second_user).and_return(shifted_second_user)

      expect(weather_service).to receive(:get_weather).with(shifted_first_user).and_return(first_users_weather) 
      expect(weather_service).to receive(:get_weather).with(shifted_second_user).and_return(second_users_weather) 

      expect(message_factory).to receive(:create).with(first_users_weather).and_return(first_users_message)
      expect(message_factory).to receive(:create).with(second_users_weather).and_return(second_users_message)

      expect(sms_service).to receive(:send).with(first_users_message)
      expect(sms_service).to receive(:send).with(second_users_message)

      GrouchSMSWeather::CLI.start(nil, grouchSMS, shifter, weather_service, message_factory, sms_service)
      
    end
  end
end
