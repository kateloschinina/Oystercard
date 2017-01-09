require 'oystercard'

describe Oystercard do

  init_amount = 50
  subject(:card1) { described_class.new }
  subject(:card2) { described_class.new init_amount }

  maximum_balance = Oystercard::MAX_BALANCE
  minimum_balance = Oystercard::MIN_BALANCE

  describe 'class exists' do
    it 'checks whether creates an instance of a class' do
      expect(card1).to be_a(Oystercard)
    end
    it 'has a balance of 0' do
      expect(card1.balance).to eq(0)
    end
  end

  describe 'accessing balance' do
    it {is_expected.to respond_to(:balance).with(0).argument}
    it 'creates an instance with balance' do
      expect(card2.balance).to eq(init_amount)
    end
  end

  describe 'top_up' do
    #it {is_expected.to respond_to(:top_up).with(1).argument}
    it 'top_ups by the number' do
      number = 10
      expect{ card1.top_up(number) }.to change{ card1.balance }.by number
    end
    it "stops user from having a balance beyond £#{maximum_balance}" do
      error_message = "Your card's balance cannot exceed £#{maximum_balance}."
      expect {card1.top_up(maximum_balance + 1)}.to raise_error (error_message)
    end
  end

  describe 'deduct' do
    #it {is_expected.to respond_to(:deduct).with(1).argument}
    it 'duducts by the number' do
      number = 3
      expect{ card1.deduct number }.to change{ card1.balance }.by -number
    end
    it "stops user from having a balance below £#{minimum_balance}" do
      error_message = "Your card's balance can't go below £#{minimum_balance}."
      expect {card1.deduct(-minimum_balance + 1)}.to raise_error(error_message)
    end
  end
end
