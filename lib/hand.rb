class Hand
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
    if type == :straight_flush

      10 ** 9 + @card_vals.max
    end
  end

private
  def hand_check
    card_vals = @cards.map { |c| c.val }
    if straight_flush?
      return :straight_flush
    end

  end

  def straight_flush?
    return false unless @cards.all?{ |s| s.suit == @cards[0].suit }
    ace_14 = @cards.map{ |c| c.val }.chunk_while{ |x,y| y==x+1 }.to_a[0].length
    ace_1 = change_ace_val_to_1.chunk_while { |x,y| y==x+1 }.to_a[0].length
    ace_14 == 5 || ace_1 == 5
  end

  def change_ace_val_to_1
    @cards.map { |c| c.val == 14 ? 1 : c.val }
  end
end
