require 'byebug'
class Player
  attr_reader :hand, :deck
  attr_accessor :bankroll, :folded

  def initialize(bankroll = 1000, deck)
    @bankroll = bankroll
    @deck = deck
  end

  def get_hand(hand)
    @hand = hand
  end

  def show
    if folded
      puts "Folded!"
      return
    end
    hand.show
  end

  def play_draw_turn
    return if folded
    draw_amt = get_draw_amt
    get_draw(draw_amt)
    take(draw_amt)
  end

  def bet(amt)
    raise StandardError.new("Player can't afford bet!") if amt > @bankroll
    @bankroll -= amt
  end

  def call_bet(amt)
    puts "call $#{amt} bet? (y/n)"
    puts "your bankroll: $#{bankroll}"
    ans = gets.chomp.upcase
    if ans == 'Y'
      bet(amt)
      amt
    else
      fold
      0
    end
  end

  def get_bet
    begin
      system("clear")
      hand.show
      puts "your bankroll: $#{bankroll}"
      puts "enter bet amount (0 to check): "
      amt = gets.to_i
      raise StandardError.new("Player can't afford bet!") if amt > @bankroll
      bet(amt)
      amt
    rescue => e
      puts e.message
      retry
    end
  end


private

  def fold
    until hand.empty? do
      discard(0)
    end
    @folded = true
  end


  def get_draw_amt
    return 0 if folded
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
    # byebug
    deck.push(hand.delete_at(card))
  end

  def take(num)
    num.times{hand.push(deck.pop!)}
    hand.update_card_vals
  end


end
