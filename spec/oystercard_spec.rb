require 'Oystercard'

describe Oystercard do
 let (:entry_station) {double :entry_station}
  it { is_expected. to respond_to{:balance}}


  describe '#top up' do

    it {is_expected.to respond_to(:top_up).with(1).argument }

    it 'can be topped up' do
      expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
    end

    it 'top up cannot allow balance to exceed £90' do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      subject.top_up(maximum_balance)
      expect{subject.top_up(1)}.to raise_error "Balance has exceeded limit of #{maximum_balance}"
    end

  end

  describe '#deduct method' do
    it 'deduct' do
      subject.top_up 50
      expect{ subject.touch_out }.to change{ subject.balance }.by -1
    end
  end

  it 'in journey' do
    expect(subject.in_journey?).to eq false
  end

  describe '#touch in' do

    it 'Touch in' do
      subject.top_up 10
      subject.touch_in(entry_station)
      expect(subject.in_journey?).to eq true
    end
    it { is_expected.to respond_to(:touch_in).with(1).argument }

  end


  describe '#touch_out' do

    before do
      subject.top_up 10
      subject.touch_in(entry_station)
    end

    it 'lets you touch out' do
      subject.touch_out
      expect(subject).not_to be_in_journey
    end

    it 'deduct by minimum fare' do
      expect{subject.touch_out}.to change {subject.balance}.by(-Oystercard::MINIMUM_CHARGE)
    end

  end

  it 'raises an error if balance is less than 1' do
    expect{subject.touch_in(entry_station)}.to raise_error "Insufficient funds"
  end

it 'forgets the entry station' do
  subject.top_up 10
  subject.touch_in(entry_station)
  subject.touch_out
  expect(subject.entry_station).to eq nil

end


  end
