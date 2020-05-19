# frozen_string_literal: true

class Oystercard
  attr_reader :balance, :entry_station

  MAXBALANCE = 90
  FARE = 1
  DEFAULT_BALANCE = 0

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
  end

  def top_up(money)
    raise 'Exceeded top up limit' if (@balance + money) > MAXBALANCE

    @balance += money
  end

  def touch_in(entry_station)
    raise 'Insufficient funds' if insufficient_funds?
    @entry_station = entry_station

  end

  def touch_out
    fare
    @entry_station = nil
  end

  def in_journey?
    !!@entry_station
  end

  private

  def fare
    @balance -= FARE
  end

  def insufficient_funds?
    @balance < FARE
  end
end
