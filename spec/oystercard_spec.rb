require 'oystercard'

describe Oystercard do

  subject(:card) { described_class.new(journey_class: Journey) }
  let(:Journey) { double(:Journey, new: current_journey) }
  let(:station) { double (:station) }
  # let(:current_journey) { double(:current_journey, :starts => nil) } #å
  let(:current_journey) { {} }
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

  describe "touch_in" do

    it "raises error if under minimum amount" do
      card.top_up(Oystercard::MIN_FARE/2)
      expect{card.touch_in(station)}.to raise_error 'Insufficient funds'
    end

    xit "starts a journey" do
      card.top_up(Oystercard::TOP_UP_LIMIT)
      expect(current_journey).to receive(:starts)
      card.touch_in(station)
    end

    it "raises error if touched in twice in a row" do
      card.top_up(Oystercard::TOP_UP_LIMIT)
      card.touch_in(station)
      expect {card.touch_in(station)}.to change{card.balance}.by(-Oystercard::PENALTY_FARE)
	  end
  end

  describe "touch_out" do

    before do
      card.top_up(Oystercard::TOP_UP_LIMIT)
    end

    it 'charges penalty fare when failure to touch in' do
      expect{card.touch_out(station)}.to change{card.balance}.by(-Oystercard::PENALTY_FARE)
    end


    it "deducts #{Oystercard::MIN_FARE} from balance" do
      card.touch_in(station)
      expect{card.touch_out(station)}.to change{card.balance}.by(-Oystercard::MIN_FARE)
    end

    context "edge cases after legal journey" do

      before do
        card.touch_in(station)
        card.touch_out(station)
      end

      it "charges penalty fare if no touch in after legal journey" do
        expect{card.touch_out(station)}.to change{card.balance}.by(-Oystercard::PENALTY_FARE)
      end

      it "creates a new journey for no touch in" do
        card.touch_out(station)
        expect(current_journey).not_to have_value(station)
      end

    end
	end
end

  # describe "history" do

	 #    it "has empty history" do
	 #    	expect(card.journeys).to be_empty
	 #    end

	 #    it "contains entry and exit station" do
	 #    	card.top_up(Oystercard::TOP_UP_LIMIT)
	 #      card.touch_in(station)
	 #      card.touch_out(station)
	 #    	expect(card.journeys).to include journey
	 #    end
  # end
