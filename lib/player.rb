class Player
  attr_reader :hand
  attr_accessor :bankroll

  def initialize(bankroll = 1000)
    @bankroll = bankroll
  end

  def get_hand(hand)
    @hand = hand
  end

  def show
    hand.show
  end

end
