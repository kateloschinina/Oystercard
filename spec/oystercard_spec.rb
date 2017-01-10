require 'oystercard'

describe Oystercard do

  init_amount = 50
  subject(:card1) { described_class.new }
  subject(:card2) { described_class.new false, init_amount }

  maximum_balance = Oystercard::MAX_BALANCE
  #minimum_balance = Oystercard::MIN_BALANCE
  min_fare = Oystercard::MIN_FARE

  describe 'class exists' do
    it 'checks whether creates an instance of a class' do
      expect(card1).to be_a(Oystercard)
    end
    it 'has a balance of nil' do
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
    number = 10
    it "top_ups by £#{number}" do
      expect{ card1.top_up(number) }.to change{ card1.balance }.by number
    end
    it "stops user from having a balance beyond £#{maximum_balance}" do
      error_message = "Your card's balance cannot exceed £#{maximum_balance}."
      expect {card1.top_up(maximum_balance + 1)}.to raise_error (error_message)
    end
  end

=begin
  describe 'deduct' do
    #it {is_expected.to respond_to(:deduct).with(1).argument}
    it 'deducts by the number' do
      number = 3
      expect{ card1.deduct number }.to change{ card1.balance }.by -number
    end
    it "stops user from having a balance below £#{minimum_balance}" do
      error_message = "Your card's balance can't go below £#{minimum_balance}."
      expect {card1.deduct(-minimum_balance + 1)}.to raise_error(error_message)
    end
  end
=end

  describe 'in_journey' do
    it 'checks that card is not in journey by default' do
      expect(card1.in_journey).to be(false)
    end
    it 'reports if the card object is in journey' do
      card1.in_journey = true
      expect(card1).to be_in_journey
    end
  end

  describe 'touch_in' do
    it 'sets value for variable in_journey to true' do
      card2.touch_in
      expect(card2).to be_in_journey
    end
    it 'raises an error if card already checked in' do
      error_message = "You have already touched in!"
      card2.in_journey = true
      expect {card2.touch_in}.to raise_error(error_message)
    end
    it 'raised an error if card has insufficient funds' do
      error_message = "Insufficient funds for the journey."
      expect{card1.touch_in}.to raise_error(error_message)
    end
  end

  describe 'touch_out' do
    it 'sets value for variable in_journey to false' do
      card1.in_journey = true
      card1.touch_out
      expect(card1).not_to be_in_journey
    end
    it "deducts the minimum fare of £#{min_fare} when touching out" do
      card2.touch_in
      expect{ card2.touch_out }.to change{ card2.balance }.by -min_fare
    end
    it 'raises an error if card already checked out' do
      error_message = "You have already touched out!"
      expect {card1.touch_out}.to raise_error(error_message)
    end
  end


end
