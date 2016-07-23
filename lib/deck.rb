require_relative 'card.rb'

class Deck
  attr_reader :store, :store

  def initialize
    @store = []
    Card::SUITS.each do |suit|
      Card::CARD_VALS.keys.each do |type|
        @store << Card.new(suit, type)
      end
    end

    def shuffle!
      @store.shuffle!
    end

    def pop!
      @store.pop
    end

    def push(card)
      @store.unshift(card)
    end

  end
end
