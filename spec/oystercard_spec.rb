require 'oystercard'

describe Oystercard do

  init_amount = 50
  let(:station) {"Bank"}
  subject(:card1) { described_class.new }
  subject(:card2) { described_class.new init_amount }

  maximum_balance = Oystercard::MAX_BALANCE
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
    number = 10
    it "top_ups by £#{number}" do
      expect{ card1.top_up(number) }.to change{ card1.balance }.by number
    end
    it "stops user from having a balance beyond £#{maximum_balance}" do
      error_message = "Your card's balance cannot exceed £#{maximum_balance}."
      expect {card1.top_up(maximum_balance + 1)}.to raise_error (error_message)
    end
  end

  describe 'in_journey' do
    let(:station) {double :station}
    it 'checks that card is not in journey by default' do
      expect(card1.in_journey?).to be(false)
    end
    it 'reports if the card object is in journey' do
      card2.touch_in(station)
      expect(card2).to be_in_journey
    end
  end

  describe 'touch_in' do
    let(:station) {double :station}
    it 'sets value for variable in_journey to true' do
      card2.touch_in(station)
      expect(card2).to be_in_journey
    end
    it 'charges a penalty if user is trying to check in while already check in' do
      station = Station.new 'angel'
      card2.touch_in(station)
      expect {card2.touch_in(station)}.to change{ card2.balance }.by -card2.penalty
    end
    it 'raised an error if card has insufficient funds' do
      error_message = "Insufficient funds for the journey."
      expect{card1.touch_in(station)}.to raise_error(error_message)
    end
    it { is_expected.to respond_to(:touch_in).with(1).argument }
  end

  describe 'touch_out' do
    let(:station) {double :station}
    it 'sets value in_journey to false' do
      station1 = 'angel'
      station2 = 'walthamstow'
      card2.touch_in(station1)
      card2.touch_out(station2)
      expect(card2).not_to be_in_journey
    end
    it "deducts the minimum fare of £#{min_fare} when touching out" do
      station1 = 'angel'
      station2 = 'walthamstow'
      card2.touch_in(station1)
      expect{ card2.touch_out(station2) }.to change{ card2.balance }.by -2
    end
    it 'already checked out' do
      expect {card2.touch_out(station)}.to change{ card2.balance }.by -card2.penalty
    end
  end

  describe 'history' do
    let(:station) {double :station}
    it 'shows the one journey history of the card' do
      station1 = 'angel'
      station2 = 'walthamstow'
      card2.touch_in(station1)
      card2.touch_out(station2)
      expect(card2.history.journeys).to eq ({"j1"=>[station1, station2]})
    end
    it 'shows the history of stations the card has been to, when more than 1' do
      n = 4
      hash = Hash.new
      station1 = 'bank'
      station2 = 'angel'
      n.times do
        card2.touch_in(station1)
        card2.touch_out(station2)
        hash.store("j#{hash.length + 1}",[station1,station2])
      end
      expect(card2.history.journeys).to eq (hash)
    end
  end
end
