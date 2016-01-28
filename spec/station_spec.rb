require 'station.rb'

describe Station do
  subject(:station) {described_class.new}
  describe '#initialize' do
    before do
      subject[:name] = 'Lewisham'
      subject[:zone] = 2
    end
    it 'initializes with a name' do
      expect(subject.name).to eq 'Lewisham'
    end

    it 'initializes with a zone' do
      expect(subject.zone).to be 2
    end
  end
end
