# frozen_string_literal: true

require 'oystercard'
describe Oystercard do
  let(:station) {double :station}
  let(:card) {Oystercard.new}
  let(:money_card) {Oystercard.new(20)}
  it 'balance has default balance of 0' do
    expect(card.instance_variable_get(:@balance)).to eq(0)
  end
  it 'initalize a different balance' do
    expect(money_card.instance_variable_get(:@balance)).to eq(20)
  end

  context 'top up' do

    it 'raises an error if balance is more than 90' do
      expect { card.top_up(Oystercard::MAXBALANCE + 1) }.to raise_error('Exceeded top up limit')
    end
  end

  context 'barriers' do

    it 'raise error when touch in and balance is less than minimum amount' do
      expect { card.touch_in(station) }.to raise_error('Insufficient funds')
    end

    it 'remembers the entry station' do
      expect(money_card.touch_in(station)).to eq(station)
    end

    it 'reduces balance by the fare amount when touched out' do
      expect { card.touch_out }.to change { card.balance }.by(-Oystercard::FARE)
    end
    it 'accepts entry station' do
      money_card.touch_in(station)
      money_card.touch_out
      expect(money_card.entry_station).nil?
    end

    it 'knows if a card is currently in journey' do
      money_card.touch_in(station)
      expect(money_card).to be_in_journey
    end

    it 'knows if a card is not currently in use' do
      money_card.touch_out
      expect(money_card).not_to be_in_journey
    end
  end
end
