require 'rspec'
require 'card'

describe Card do
  let(:card) { Card.new(:spades, :ten) }

  describe '#initialize' do
    it 'creates new cards given a suit and a type' do
      expect(card.suit).to eq (:spades)
      expect(card.type).to eq (:ten)
      expect(card.val).to eq (10)
    end
  end
end
