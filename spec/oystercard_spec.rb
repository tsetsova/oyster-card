require 'oystercard'

describe Oystercard do
  subject(:card){described_class.new}
	it "new card balance == 0" do
		expect(card.balance).to eq 0
	end
  context "Changing Balance" do
    it "Topping up Balance" do
      expect{card.top_up(10)}.to change{ card.balance}.by 10
    end
    it "" do

    end

  end
end