require 'byebug'
class ComputerPlayer
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
    draw_amt = get_draw
    take(draw_amt)
  end

  def bet(amt)
    raise StandardError.new("Player can't afford bet!") if amt > @bankroll
    @bankroll -= amt
  end

  def call_bet(amt)
    score = hand.score
    if score > 10_000_000
      call = true
    elsif score > 1_000_000
      amt <= (@bankroll / 1.5 )? (call = true ): (call = false)
    elsif score > 10_000
      amt <= (@bankroll / 3 )? (call = true ): (call = false)
    elsif score > 1_000
      amt <= rand * (@bankroll / 8 )? (call = true ): (call = false)
    elsif score > 100
      amt <= rand * (@bankroll / 16) ? (call = true ): (call = false)
    else
      amt <= (rand + 0.5) * @bankroll ? call = true : call = false
    end
    if call
      puts "Computer player calls!"
      bet(amt)
      amt
    else
      puts "Computer Player folds!"
      fold
      0
    end
  end

  def get_bet
    score = hand.score
    if score > 10_000_000
      amt = @bankroll
      print "ALL IN! "
    elsif score > 1_000_000
      amt = rand * (@bankroll / 2)
    elsif score > 10_000
      amt = rand * (@bankroll / 4)
    elsif score > 1_000
      amt = rand * (@bankroll / 8)
    elsif score > 100
      amt = rand * (@bankroll / 16)
    else
      amt = (rand * 0.25 * @bankroll / 32)
    end
    print "Computer player bets $#{amt.round} \n" unless amt.round < 13
    amt.round > 13 ? (return amt.round) : (return 0)
  end


private

  def fold
    until hand.empty? do
      discard(0)
    end
    @folded = true
  end

  def get_draw
    result = []
    (0..4).each do |i|
      new_hand = hand.dup
      new_hand.delete_at(i)
      new_score = new_hand.score
      result << i if new_score >= hand.score
    end
    j = 0
    result[0..2].each do |i|
      discard(i - j)
      j += 1
    end
    result.length > 3 ? result = 3 : result = result.length
    puts "Computer player discards #{result} cards"
    result
  end

  def discard(card_idx)
    # byebug
    deck.push(hand.delete_at(card_idx))
  end

  def take(num)
    num.times{hand.push(deck.pop!)}
    hand.update_card_vals
  end


end
