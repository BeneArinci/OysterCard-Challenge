require 'journey'
require 'oystercard'

describe Journey do
  let(:journey) { Journey.new }
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  let(:journeys) { { entry_station: entry_station, exit_station: exit_station } }
  let(:balance) { double :Oystercard.balance }
  let(:card) { Oystercard.new(50) }
  
  it 'is an instance of Journey' do
    expect(journey).to be_instance_of Journey
  end

  it 'should start a journey' do
    expect(journey.start_journey(entry_station)).to eq(entry_station)
  end

  it 'should initialize with an empty array' do
    expect(journey.journeys).to be_empty
  end

  it 'should store a journey' do
    journey.start_journey(entry_station)
    journey.end_journey(exit_station)
    expect(journey.journeys).to eq([journeys])
  end

  it 'should know if a journey is complete' do
    journey.start_journey(entry_station)
    journey.end_journey(exit_station)
    expect(journey).to be_complete
  end

  it 'should know if a journey is not complete' do
    expect(journey).not_to be_complete
  end

end