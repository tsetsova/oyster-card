require 'journey'

describe Journey do

subject(:journey) { described_class.new oystercard.entry_station }
let(:oystercard) {double :oystercard}

before do
  allow(oystercard).to receive(:entry_station).and_return 'aldgate'
  allow(oystercard).to receive(:exit_station).and_return 'brockley'
end

  it 'starts a journey' do
    expect(journey.entry_station).to eq 'aldgate'
  end

  it 'ends a journey' do
    expect(journey.end_journey(oystercard.exit_station)).to eq 'brockley'
  end

end
