require 'oystercard'

describe Oystercard do
  subject(:card){described_class.new}

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
  		card.touch_in
  		expect(card).to be_in_journey
  	end

  	it 'touch out changes in_journey? to false' do
  		card.touch_in
  		card.touch_out
  		expect(card).not_to be_in_journey
  	end
  end

  describe "touch_in" do

    it "raises error if under minimum amount" do
      card.top_up(Oystercard::MIN_FARE/2)
      expect{card.touch_in}.to raise_error 'Insufficient funds'

    end
  end

  describe "touch_out" do

    it "deducts #{Oystercard::MIN_FARE} from balance" do
      card.top_up(Oystercard::TOP_UP_LIMIT)
      card.touch_in
      expect{card.touch_out}.to change{card.balance}.by(-Oystercard::MIN_FARE)
    end
  end



end