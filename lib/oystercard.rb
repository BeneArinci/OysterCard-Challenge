# frozen_string_literal: true

class Oystercard
  attr_reader :balance, :injourney

  MAXBALANCE = 90
  FARE = 1
  DEFAULT_BALANCE = 0

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @injourney = false
  end

  def top_up(money)
    raise 'Exceeded top up limit' if (@balance + money) > MAXBALANCE

    @balance += money
  end

  def touch_in
    raise 'Insufficient funds' if insufficient_funds?

    @injourney = true
  end

  def touch_out
    fare
    @injourney = false
  end

  def in_journey?
    @injourney
  end

  private

  def fare
    @balance -= FARE
  end

  def insufficient_funds?
    @balance < FARE
  end
end
