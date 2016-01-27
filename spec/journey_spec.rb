require 'journey'

describe Journey do

subject(:journey) { described_class.new oystercard.entry_station }
let(:oystercard) {double :oystercard}

  it 'start a journey' do
    allow(oystercard).to receive(:entry_station).and_return 'aldgate'
    expect(journey.entry_station).to eq 'aldgate'
  end

end
