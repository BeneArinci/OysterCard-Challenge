# frozen_string_literal: true

class Oystercard
  attr_reader :balance, :entry_station, :journey, :exit_station

  MAXBALANCE = 90
  FARE = 2
  DEFAULT_BALANCE = 0

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @journey = Journey.new
  end

  def top_up(money)
    raise 'Exceeded top up limit' if (@balance + money) > MAXBALANCE

    @balance += money
  end

  def touch_in(entry_station)
    raise 'Insufficient funds' if insufficient_funds?

    @journey.start_journey(entry_station)
  end

  def touch_out(exit_station)
    @journey.end_journey(exit_station)
  end

  def fare
    @balance -= @journey.fare
  end

  private

  def insufficient_funds?
    @balance <= FARE
  end
end
