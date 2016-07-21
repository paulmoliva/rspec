require 'rspec'
require 'deck'

describe Deck do
  let(:deck) { Deck.new }
  let(:spades){deck.store.select { |el| el.suit == :spades}}
  let(:clubs){deck.store.select { |el| el.suit == :clubs}}
  let(:diamonds){deck.store.select { |el| el.suit == :diamonds}}
  let(:hearts){deck.store.select { |el| el.suit == :hearts}}
  describe 'initialize' do
    it 'holds 52 cards' do
      expect(deck.store.length).to eq (52)
    end

    it 'all cards are Card objects' do
      expect(deck.store.all? { |el| el.is_a?(Card) }).to be_truthy
    end

    it 'creates 13 of each suit' do
      expect(spades.length).to eq (13)
      expect(clubs.length).to eq (13)
      expect(diamonds.length).to eq (13)
      expect(hearts.length).to eq (13)
    end
    it 'each suit contains correct cards' do
      suits = [spades, clubs, hearts, diamonds]
      suits.each do |suit|
        expect(suit.map{|el| el.val}.flatten.sort).to eq([2,3,4,5,6,7,8,9,10,11,12,13,14])
      end
    end
  end
end
