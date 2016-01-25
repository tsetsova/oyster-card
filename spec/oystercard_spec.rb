require 'oystercard'

describe Oystercard do
	it "new card balance == 0" do
		expect(subject.balance).to eq 0
	end
end