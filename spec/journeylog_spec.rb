require "journeylog"

describe JourneyLog do
	#check starts
	#check ends
	#check history starts empty
	#check history entry exists
	#check incomplete journey history edge cases


	let(:station) {double(:station)}
	let(:journey_class) {double(:journey_class, new: journey)}
	let(:journey) {double(:journey)}
 	subject(:journeylog) { described_class.new(journey_class: journey_class) }

	it "calls start on journey" do
		expect(journey).to receive(:starts)
		journeylog.starts_journey(station)
	end

end