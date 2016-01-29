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

  context '#start_journey' do
    xit 'instantiates a new journey' do
      expect(journey_class).to receive(:new)
      journey_log.start_journey station
    end

    context 'when receiving a new station' do
      before do
        journey_log.start_journey station
      end
      it 'has an entry_station' do
        expect(journey_log.entry_station).to eq station
      end
    end

  end

  context '#current_journey' do

  end

  context '#end_journey' do

  end

  context '#log_history' do

  end
end
