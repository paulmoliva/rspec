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
    @card_vals = @cards.map { |c| c.val }
  end

  def add_card(card)
    cards << card
  end

  def remove_card(idx)
    cards.delete_at(idx)
  end

  def score
    type = hand_check
    base_score = 10 ** HAND_MAGNITUDES[type]
    if type == :straight_flush || type == :straight
      base_score + @card_vals.max
    elsif type == :four_of_a_kind || type == :three_of_a_kind
      base_score + sort_by_rank[2]
    elsif type == :full_house
      base_score + @card_vals.max
    elsif type == :flush
      base_score + @card_vals.max
    elsif type == :two_pair
      base_score + sort_by_rank[3]
    elsif type == :one_pair
      base_score + sort_by_rank.select{|el| sort_by_rank.count(el) == 2}[0]
    elsif type == :high_card
      sort_by_rank.last
    end
  end

private
  def hand_check
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
    @card_vals.sort.chunk_while{|x, y| x == y}.to_a.length == 3
  end

  def one_pair?
    @card_vals.any?{|el| @card_vals.count(el) == 2}
  end

  def change_ace_val_to_1
    @cards.map { |c| c.val == 14 ? 1 : c.val }
  end
end
