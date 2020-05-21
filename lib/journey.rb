require_relative 'oystercard'
class Journey
  attr_reader :journeys

  MIN_FARE = 1
  PENALTY_FARE = 6

  def initialize
    @journeys = []
  end
  
  def start_journey(entry_station)
    @entry_station = entry_station
  end

  def end_journey(exit_station)
    @exit_station = exit_station
    @journeys << {entry_station: @entry_station, exit_station: @exit_station}
    @entry_station = nil
  end

  def in_journey?
    !!@entry_station
  end

  def fare
    
  end

end