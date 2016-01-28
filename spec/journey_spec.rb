require 'journey'

describe Journey do

subject(:journey)   { described_class.new entry_station }
let(:entry_station) {double :station}
let(:exit_station)  {double :station}

before do
  allow(entry_station).to receive(:zone).and_return 1
  allow(exit_station).to receive(:zone).and_return 3
  allow(entry_station).to receive(:name).and_return 'aldgate'
  allow(exit_station).to receive(:name).and_return 'brockley'
end

  describe '#initialize' do
    it 'initializes with an entry station' do
      expect(journey.entry_station).to eq entry_station
    end
  end

  describe '#end_journey' do
    it 'ends a journey' do
      expect(journey.end_journey(exit_station).name).to eq 'brockley'
    end
  end

  describe '#calculate_fare' do
    context 'when the user does not touch in' do
      let(:new_journey) {described_class.new}
      it 'returns a penalty charge' do
        expect(subject.calculate_fare).to eq described_class::PENALTY_FARE
      end
    end
    context 'when the user does not touch out' do
      it 'returns a penalty charge' do
        expect(journey.calculate_fare).to eq described_class::PENALTY_FARE
      end
    end

    context 'when the user completes a journey' do
      it 'calculates the correct fare' do
        journey.end_journey(exit_station)
        expect(journey.calculate_fare).to eq described_class::MINIMUM_CHARGE
      end
    end
  end
end
