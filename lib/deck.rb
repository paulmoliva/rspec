require_relative 'card.rb'

class Deck
  attr_reader :store

  def initialize
    @store = []
    Card::SUITS.each do |suit|
      Card::CARD_VALS.keys.each do |type|
        @store << Card.new(suit, type)
      end
    end

  end
end
