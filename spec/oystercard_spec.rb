require 'oystercard'

describe Oystercard do

  init_amount = 50
  subject(:card1) { described_class.new }
  subject(:card2) { described_class.new init_amount }

  describe 'class exists' do
    it 'checks whether creates an instance of a class' do
      expect(card1).to be_a(Oystercard)
    end
  end

  describe 'accessing balance' do
    it {is_expected.to respond_to(:balance).with(0).argument}
    it 'creates an instance with balance' do
      expect(card2.balance).to eq(init_amount)
    end
  end

  describe 'top_up' do
    it {is_expected.to respond_to(:top_up).with(1).argument}
    it 'top_ups by the number' do
      number = 10
      card1.top_up(number)
      expect(card1.balance).to eq(number)
    end
  end
end
