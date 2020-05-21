require 'station'

describe Station do
  let(:station) {Station.new("Stratford", 2)}
  it 'creates an instance of the class' do
    expect(station).to be_instance_of Station
  end
  it 'initializes @name instance variable' do
    expect(station.name).to eq("Stratford")
    #expect(station.instance_variable_get(:@name)).to eq("Stratford")
  end
  it 'initializes @zone instance variable' do
    expect(station.instance_variable_get(:@zone)).to eq(2)
  end

end
