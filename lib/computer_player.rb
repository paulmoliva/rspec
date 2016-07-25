require 'byebug'
class ComputerPlayer
  attr_reader :hand, :deck
  attr_accessor :bankroll, :folded

  HAND_PROBS = {
    high_card: 0.5011,
    one_pair:	0.422569,
    two_pair:	0.047539,
    three_of_a_kind:	0.0211285,
    full_house:	0.00144058,
    four_of_a_kind:	0.000240096	,
    straight:	0.00392465,
    flush: 0.0019654,
    straight_flush:	0.0000138517 + 0.00000153908,
  }

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
    mult = (1 - HAND_PROBS[hand.hand_check])
    score = hand.score
    if score > 10_000_000
      call = true
    elsif score > 1_000_000
      amt <= (1000 / 1.25 ) * (rand + mult) ? (call = true ) : (call = false)
    elsif score > 10_000
      amt <= (1000 / 1.5 ) * (rand + mult) ? (call = true ) : (call = false)
    elsif score > 1_000
      amt <= mult * (1000 / 2 ) * (rand + mult) ? (call = true ) : (call = false)
    elsif score > 100
      amt <= mult * (1000 / 3) * (rand + mult) ? (call = true ) : (call = false)
    else
      amt <= (mult) * (1000 / 24) ? (call = true) : (call = false)
    end
    if call
      puts "Computer player calls!"
      sleep(1)
      bet(amt)
      amt
    else
      puts "Computer Player folds!"
      sleep(1)
      fold
      0
    end
  end

  def get_bet
    score = hand.score
    mult = (1 - HAND_PROBS[hand.hand_check])
    if score > 10_000_000
      amt = @bankroll
      print "ALL IN! "
    elsif score > 1_000_000
      amt = mult * (@bankroll / 2) * (rand + mult)
    elsif score > 10_000
      amt = mult * (@bankroll / 4) * (rand + mult)
    elsif score > 1_000
      amt = mult * (@bankroll / 6) * (rand + mult)
    elsif score > 100
      amt = mult * (@bankroll / 12) * (rand + mult)
    else
      amt = (mult * 0.25 * @bankroll / 24) * (rand + mult)
    end
    print "Computer player bets $#{amt.round} \n" unless amt.round < 13
    amt.round > 13 ? (return amt.round) : (return 0)
  end


  def discard(card_idx)
    # byebug
    deck.push(hand.delete_at(card_idx))
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

  def take(num)
    num.times{hand.push(deck.pop!)}
    hand.update_card_vals
  end


end
