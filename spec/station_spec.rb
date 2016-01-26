require 'station'

describe Station do
	subject(:station){described_class.new(9)}
	it {is_expected.to respond_to :zone}




end