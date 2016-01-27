require 'Oystercard'

describe Oystercard do
  subject(:oystercard) {described_class.new}
  let(:entry_station) {double :station}
  let(:exit_station) {double :station}
  let(:journey) { {entry_station: entry_station, exit_station: exit_station}}

  it { is_expected. to respond_to{:balance}}

  describe '#initialize' do
    it 'initializes with 0 balance and an empty history' do
      expect(oystercard.balance).to eq 0
      expect(oystercard.history).to be_empty
    end
  end

  before do
    allow(entry_station).to receive(:zone).and_return(4)
    allow(exit_station).to receive(:zone) {2}
  end


  describe '#top up' do

    it {is_expected.to respond_to(:top_up).with(1).argument }

    it 'can be topped up' do
      expect{ oystercard.top_up 1 }.to change{ oystercard.balance }.by 1
    end

    it 'top up cannot allow balance to exceed £90' do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      oystercard.top_up(maximum_balance)
      expect{oystercard.top_up(1)}.to raise_error "Balance has exceeded limit of #{maximum_balance}"
    end

  end

  it 'in journey' do
    expect(oystercard.in_journey?).to eq false
  end

  describe '#touch in' do

    before do
      oystercard.top_up 10
      oystercard.touch_in(entry_station)
    end

    it 'Touch in' do
      expect(oystercard.in_journey?).to eq true
    end
    it 'can access a station zone via entry_station' do
      expect(oystercard.entry_zone).to be(4)
    end
  end


  describe '#touch_out' do

    before do
      oystercard.top_up 10
      oystercard.touch_in(entry_station)
    end

    it 'lets you touch out' do
      oystercard.touch_out(exit_station)
      expect(oystercard).not_to be_in_journey
    end

    it 'deduct by minimum fare' do
      expect{oystercard.touch_out(exit_station)}.to change {oystercard.balance}.by(-Oystercard::MINIMUM_CHARGE)
    end

    it 'forgets the entry station' do
      oystercard.touch_out(exit_station)
      expect(oystercard.entry_station).to eq nil
    end

    it 'stores an exit station' do
      oystercard.touch_out(exit_station)
      expect(oystercard.journey[:exit_station]).to eq exit_station
    end

    it 'stores a journey' do
      oystercard.touch_out(exit_station)
      expect(oystercard.history).to include journey
    end

    it 'can access a station zone via exit_station' do
      #allow(exit_station).to receive(:zone) {2}
      oystercard.touch_out(exit_station)
      expect(oystercard.exit_zone).to be(2)
    end

  end

  context 'user failing to touch in or out' do

    # it 'charges a penalty fare if the user does not touch out' do
    #   oystercard.top_up 10
    #   expect{2.times{oystercard.touch_in(entry_station)}}.to change{oystercard.balance}.by(-6)
    # end
  end

  it { is_expected.to respond_to(:touch_out).with(1).argument }

  it 'raises an error if balance is less than 1' do
    expect{oystercard.touch_in(entry_station)}.to raise_error "Insufficient funds"
  end



end
