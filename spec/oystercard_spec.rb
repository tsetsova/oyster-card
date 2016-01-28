require 'Oystercard'

describe Oystercard do
  subject(:oystercard) {described_class.new}
  let(:entry_station) {double :station}
  let(:exit_station) {double :station}
  let(:journey) { double :journey }

  describe '#initialize' do
    it 'initializes with 0 balance' do
      expect(oystercard.balance).to eq 0
    end

    it 'initializes with an empty journey history' do
      expect(oystercard.history).to be_empty
    end

    it 'initializes with a default status of not in journey' do
      expect(oystercard.in_journey?).to be_falsey
    end
  end

  before do
    allow(entry_station).to receive(:zone) { 4 }
    allow(exit_station).to receive(:zone) { 2 }
  end

  describe '#top up' do
    it 'adds money to card balance' do
      expect { oystercard.top_up 1 }.to change { oystercard.balance }.by 1
    end

    context "when balance exceeds #{described_class::MAXIMUM_BALANCE}" do
      it 'raises an error' do
        oystercard.top_up(described_class::MAXIMUM_BALANCE)
        expect do
          oystercard.top_up(1)
        end.to raise_error "Balance has exceeded limit of #{described_class::MAXIMUM_BALANCE}"
      end
    end
  end

  describe '#in_journey?' do
    before do
      oystercard.top_up 10
    end

    it 'returns journey status' do
      oystercard.touch_in(entry_station)
      expect(oystercard.in_journey?).to be_truthy
    end
  end

  describe '#touch_in' do
    context "when balance is less than #{described_class::MINIMUM_CHARGE}" do
      let(:empty_card) { described_class.new }
      it 'raises an error' do
        expect do
          empty_card.touch_in(entry_station)
        end.to raise_error "Insufficient funds"
      end
    end

    before do
      oystercard.top_up 10
    end

    it 'changes card status to in journey' do
      oystercard.touch_in(entry_station)
      expect(oystercard.in_journey?).to be_truthy
    end
  end


  describe '#touch_out' do
    before do
      oystercard.top_up 10
      oystercard.touch_in(entry_station)
    end

    it 'changes card status to not in journey' do
      oystercard.touch_out(exit_station)
      expect(oystercard).not_to be_in_journey
    end

    it 'deducts journey fare' do
      expect do
        oystercard.touch_out(exit_station)
      end.to change { oystercard.balance }.by(-described_class::MINIMUM_CHARGE)
    end

    it 'stores a journey' do
      oystercard.touch_out(exit_station)
      expect(oystercard.history).not_to be_empty
    end
  end
end
