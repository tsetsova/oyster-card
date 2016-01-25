require 'Oystercard'
describe Oystercard do
it {is_expected.to respond_to(:balance)}

it 'can be topped up' do
  oyster = Oystercard.new

  oyster.top_up(100)
  expect(subject.balance).to eq 100
end
end
