# frozen_string_literal: true

require 'oystercard'

describe Oystercard do
  it 'balance has default balance of 0' do
    expect(subject.instance_variable_get(:@balance)).to eq(0)
  end
  it 'initalize a different balance' do
    expect(Oystercard.new(30).instance_variable_get(:@balance)).to eq(30)
  end
  it 'initiates a injourney instance variable equal to false' do
    expect(subject.instance_variable_get(:@injourney)).to eq(false)
  end

  context 'top up' do
    it 'tops up the card' do
      test_variable = Oystercard.new
      test_variable.top_up(20)
      expect(test_variable.top_up(10)).to eq(30)
    end

    it 'raises an error if balance is more than 90' do
      expect { subject.top_up(91) }.to raise_error('Exceeded top up limit')
    end
  end

  context 'barriers' do
    it 'makes a customer be in journey' do
      expect(Oystercard.new(10).touch_in).to eq(true)
    end

    it 'raise error when touch in and balance is less than minimum amount' do
      expect { Oystercard.new.touch_in }.to raise_error('Insufficient funds')
    end

    it 'knows if a card has been touched out and interupt the journey' do
      expect(subject.touch_out).to eq(false)
    end

    it 'reduces balance by the fare amount when touched out' do
      expect { subject.touch_out }.to change { subject.balance }.by(-Oystercard::FARE)
    end

    it 'knows if a card is currently in journey' do
      card = Oystercard.new(10)
      card.touch_in
      expect(card).to be_in_journey
    end

    it 'knows if a card is not currently in use' do
      card = Oystercard.new
      card.touch_out
      expect(card).not_to be_in_journey
    end
  end
end
