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

  it 'starts a journey' do
    expect(journey.entry_station.name).to eq 'aldgate'
  end

  it 'ends a journey' do
    expect(journey.end_journey(exit_station).name).to eq 'brockley'
  end

  it 'has an entry zone' do
    expect(journey.start_journey).to eq 1
  end

end
