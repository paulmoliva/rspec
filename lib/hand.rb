require_relative 'card.rb'
require_relative 'deck.rb'

class Hand

  HAND_MAGNITUDES = {
    straight_flush: 9,
    four_of_a_kind: 8,
    full_house: 7,
    flush: 6,
    straight: 5,
    three_of_a_kind: 4,
    two_pair: 3,
    one_pair: 2,
    high_card: 1
  }

  attr_reader :cards, :card_vals
  def initialize(cards)
    @cards = cards
    update_card_vals
  end

  def dup
    new_cards = []
    @cards.each{|c| new_cards << c.dup}
    new_hand = Hand.new(new_cards)
    new_hand
  end

  def length
    @cards.length
  end

  def delete_at(i)
    return_val = @cards[i]
    @cards.delete_at(i)
    update_card_vals
    return_val
  end

  def add_card(card)
    cards << card
  end

  def remove_card(idx)
    delete_at(idx)
  end

  def score
    return 0 if length == 0
    type = hand_check
    base_score = 10 ** HAND_MAGNITUDES[type]
    if type == :straight_flush || type == :straight || type == :flush ||
      type == :full_house
      base_score + @card_vals.max
    elsif type == :four_of_a_kind || type == :three_of_a_kind
      base_score + sort_by_rank[2]
    # elsif type == :full_house
    #   base_score + @card_vals.max
    elsif type == :two_pair
      base_score + sort_by_rank[(length + 1) / 2]
    elsif type == :one_pair
      base_score + sort_by_rank.select{|el| sort_by_rank.count(el) == 2}[0]
    elsif type == :high_card
      sort_by_rank.last
    end
  end

  def <=>(other_hand)
    if score > other_hand.score
      return 1
    elsif score < other_hand.score
      return -1
    else
      return tiebreaker(other_hand)
    end
  end

  def show
    #print_card_border
    sort_cards_by_rank.each{|c| print c.top_print_type}
    puts ""
    sort_cards_by_rank.each{|c| print c.print_suit}
    puts ""
    sort_cards_by_rank.each{|c| print c.bottom_print_type}
    puts ""
    #print_card_border
    puts "\t#{hand_type_to_s}"
  end

  def push(card)
    @cards << card
  end

  def update_card_vals
    @card_vals = @cards.map { |c| c.val }
  end

  def [](i)
    @cards[i]
  end

  def empty?
    length == 0
  end

protected
  def chunk_hand_vals
    sort_by_rank.chunk_while{|x,y| x == y}.to_a.map(&:first)
  end

private

  def hand_type_to_s
    hand_check.to_s.split("_").join(" ") + "!"
  end

  def sort_cards_by_rank
    @cards.sort!{|h, l| l.val <=> h.val}
  end

  def hand_check
    # byebug
    if straight_flush?
      return :straight_flush
    elsif four_of_a_kind?
      return :four_of_a_kind
    elsif full_house?
      return :full_house
    elsif flush?
      return :flush
    elsif straight?
      return :straight
    elsif three_of_a_kind?
      return :three_of_a_kind
    elsif two_pair?
      return :two_pair
    elsif one_pair?
      return :one_pair
    else
      return :high_card
    end
  end

  def tiebreaker(other_hand)
    my_card_vals = chunk_hand_vals
    other_hand_vals = other_hand.chunk_hand_vals
    until my_card_vals.empty?
      my_card = my_card_vals.pop
      other_card = other_hand_vals.pop
      if my_card > other_card
        return 1
      elsif other_card > my_card
        return -1
      end
    end
    0
  end



  def sort_by_rank
    @card_vals.sort
  end

  def straight_flush?
    straight? && flush?
  end

  def straight?
    ace_14 = @card_vals.sort.chunk_while{ |x,y| y==x+1 }.to_a[0].length
    ace_1 = change_ace_val_to_1.sort.chunk_while { |x,y| y==x+1 }.to_a[0].length
    ace_14 == 5 || ace_1 == 5
  end

  def flush?
    @cards.all?{ |s| s.suit == @cards[0].suit }
  end

  def four_of_a_kind?
    @card_vals.any?{|el| @card_vals.count(el) == 4}
  end

  def three_of_a_kind?
    @card_vals.any?{|el| @card_vals.count(el) == 3}
  end

  def full_house?
    three_of_a_kind? && one_pair?
  end

  def two_pair?
    @card_vals.sort.chunk_while{|x, y| x == y}.to_a.length == 3 && length == 5
  end

  def one_pair?
    @card_vals.any?{|el| @card_vals.count(el) == 2}
  end

  def change_ace_val_to_1
    @cards.map { |c| c.val == 14 ? 1 : c.val }
  end

  def print_card_border
    5.times do
      print "   ".colorize( :background => :white) + " "
    end
    puts ""
  end
end

if __FILE__ == $PROGRAM_NAME
  deck = Deck.new
  deck.shuffle!
  h1 = []
  h2 = []
  5.times {h1 << deck.store.pop}
  5.times {h2 << deck.store.pop}
  hand1 = Hand.new(h1)
  hand2 = Hand.new(h2)
  hand1.show
  hand2.show
end
