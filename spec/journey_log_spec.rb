require 'journey_log'

describe JourneyLog do

  subject(:journey_log) { described_class.new  }

  describe 'class creation' do
    let(:station) {double :station}
    it 'when starts journey it stores a parameter journey class' do
      journey_log.start_journey(station)
      expect(journey_log.journey_class).to be_a(Journey)
    end
  end

  describe 'start journey' do
    let(:station) {double :station}
    it 'initializes new journey' do
      journey_log.start_journey(station)
      expect(journey_log.journey_class).to be_a(Journey)
    end
    it 'sets current journey to true' do
      journey_log.start_journey(station)
      expect(journey_log.current_journey).to be_truthy
    end
  end

  describe 'finish journey' do
    let(:station) {double :station}
    it 'adds to hash' do

    end
    it 'sets current journey to false' do
      #journey_log.finish_journey(station)
      #expect(journey_log.current_journey).to be_falsey
    end
    it 'sets current journey to true' do
      #journey_log.start_journey(station)
      #expect(journey_log.current_journey).to be_truthy
    end
  end

end
