require 'station.rb'

describe Station do
  subject(:station) {described_class.new 'Lewisham', 2}
  before do

  end
  it 'initializes with a name' do
    expect(subject.name).to be('Lewisham')
  end

  it 'initializes with a zone' do
    expect(subject.zone).to be(2)
  end

  it 'can have its attributes changed' do
    
  end
end
