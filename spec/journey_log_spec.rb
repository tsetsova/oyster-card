require 'journey_log'

describe Journey_log do
  subject(:journey_log) {described_class.new(journey_class: journey_class)}
  let(:station) {double :station}
  let(:journey_class) {double(:journey_class, new: journey)}
  let(:journey) {double :journey}

  context '#initialize' do
    it 'has an empty history' do
      expect(journey_log.log_history).to be_empty
    end
  end

  context '#current_journey' do

  end

  context '#log_history' do
    it 'returns a collection of previous journeys' do
      journey_log.start_journey(station)
      journey_log.end_journey(station)
      journey_log.collects_log
      expect(journey_log.view_history).not_to be_empty
    end
  end
end
