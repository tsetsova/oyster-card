require 'journey'

describe Journey do

subject(:journey) { described_class.new entry_station }
let(:entry_station) {double :station}
let(:exit_station) {double :station}

before do
  allow(entry_station).to receive(:zone).and_return 1
  allow(entry_station).to receive(:name).and_return 'aldgate'
  allow(exit_station).to receive(:name).and_return 'brockley'
end

  describe '#initialize' do
    it 'initializes with an entry_station' do
      expect(journey.entry_station).to eq entry_station
    end
  end

  # it 'starts a journey' do
  #   expect(journey.entry_station.name).to eq 'aldgate'
  # end

  describe '#end_journey' do
    it 'ends a journey' do
      expect(journey.end_journey(exit_station).name).to eq 'brockley'
    end
  end

  describe '#calculate_fare' do
    it 'deducts a penalty charge if the user does not touch in or out' do
      expect(subject.calculate_fare).to eq Journey::PENALTY_FARE
    end
  end


end
