class Player
  attr_reader :hand, :deck
  attr_accessor :bankroll

  def initialize(bankroll = 1000, deck)
    @bankroll = bankroll
    @deck = deck
  end

  def get_hand(hand)
    @hand = hand
  end

  def show
    hand.show
  end

  def get_draw_amt
    begin
      puts "How many cards would you ike to draw?"
      hand.show
      ans = gets.to_i
      raise StandardError.new ("Must draw between 0 and 3 cards") unless ans.between?(0,3)
      ans
    rescue => e
      system("clear")
      puts "Error! #{e.message}"
      retry
    end
  end
require 'byebug'
  def get_draw(num)
    num.times do
      system("clear")
      begin
        puts "Select card # to discard."
        1.upto(hand.length) {|i| print "#{i}    "}
        puts ""
        hand.show
        ans = gets.to_i
        # byebug
        raise StandardError.new ("not a valid card number.") unless ans.between?(1, hand.length)
        discard(ans - 1)
      rescue => e
        system("clear")
        puts "Error! #{e.message}"
        retry
      end
    end
  end

  def discard(card)
    deck.push(hand.delete_at(card))
  end

  def take(num)
    num.times{hand.push(deck.pop!)}
    hand.update_card_vals
  end


end
