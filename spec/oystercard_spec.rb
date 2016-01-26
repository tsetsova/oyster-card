require 'oystercard'

describe Oystercard do
  subject(:card){described_class.new}
  let(:station){double (:station)}
  let(:journey) { {entry_station: station, exit_station: station} }

  it "new card balance == 0" do
		  expect(card.balance).to eq 0
  end

  describe "top_up" do
    it "topping up balance" do
      expect{card.top_up(10)}.to change{card.balance}.by 10
    end

    it "raises error if over limit" do
    	expect{card.top_up(Oystercard::TOP_UP_LIMIT + 1)}.to raise_error "Exceeds £#{Oystercard::TOP_UP_LIMIT} top up limit."
    end
  end

  context "in_journey?" do

  	before do
  		card.top_up(Oystercard::TOP_UP_LIMIT)
  	end

  	 it 'start of journey in_journey? is false' do
  		expect(card).not_to be_in_journey
  	end

  	it 'touch in changes in_journey? to true' do
  		card.touch_in(station)
  		expect(card).to be_in_journey
  	end

  	it 'touch out changes in_journey? to false' do
  		card.touch_in(station)
  		card.touch_out(station)
  		expect(card).not_to be_in_journey
  	end
  end

  describe "touch_in" do

    it "raises error if under minimum amount" do
      card.top_up(Oystercard::MIN_FARE/2)
      expect{card.touch_in(station)}.to raise_error 'Insufficient funds'
    end

    it "changes entry_station to the entry station" do
      card.top_up(Oystercard::TOP_UP_LIMIT)
      expect{card.touch_in(station)}.to change{card.entry_station}.to (station)
    end

    it "resets exit_station to nil" do
    	card.top_up(Oystercard::TOP_UP_LIMIT)
    	card.touch_in(station)
      expect(card.exit_station).to eq(nil)
    end
	end

  describe "touch_out" do

    before do
      card.top_up(Oystercard::TOP_UP_LIMIT)
      card.touch_in(station)
    end

    it "deducts #{Oystercard::MIN_FARE} from balance" do
      expect{card.touch_out(station)}.to change{card.balance}.by(-Oystercard::MIN_FARE)
    end

    it "resets entry_station to nil" do
      expect{card.touch_out(station)}.to change{card.entry_station}.to (nil)
    end

    it "sets exit_station" do
      expect{card.touch_out(station)}.to change{card.exit_station}.to (station)
    end
	end

  describe "history" do

	    it "has empty history" do
	    	expect(card.journeys).to be_empty
	    end

	    it "contains entry and exit station" do
	    	card.top_up(Oystercard::TOP_UP_LIMIT)
	      card.touch_in(station)
	      card.touch_out(station)
	    	expect(card.journeys).to include journey
	    end
  end
end