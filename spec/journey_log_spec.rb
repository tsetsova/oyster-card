require 'journey_log'

describe Journey_log do
  subject(:journey_log) {described_class.new station journey_class: journey_class}
  let(:station) {double :station}
  let(:journey) {double :journey}
  before do
    allow
  end
  context '#initialize' do
    it 'has an empty history' do
      expect(journey_log.log_history).to be_empty
    end

    it 'has an entry_station' do
      expect(journey_log.entry_station).to eq station
    end
  end

  context '#start_journey' do
    it 'instantiates a new journey' do
      expect(journey).to receive(:new)
      journey_log.start_journey
    end
  end

  context '#current_journey' do

  end

  context '#end_journey' do

  end

  context '#log_history' do

  end
end
