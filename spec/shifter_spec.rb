require_relative '../lib/GrouchSMSWeather'

describe GrouchSMSWeather::Shifter do
  it 'shifts latitude' do
    user = {"latitude" => 53.466, "longitude" => -2.233 }
    expect(subject.shift(user)["latitude"]).to eq(-53.466)
  end

  it 'shifts longitude' do
    user = {"latitude" => 53.466, "longitude" => -2.233 }
    expect(subject.shift(user)["longitude"]).to eq(177.767)
  end
end
