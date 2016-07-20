class Card
  CARD_VALS = {
    :two => 2,
    :three =>3,
    :four => 4,
    :five => 5,
    :six => 6,
    :seven => 7,
    :eight => 8,
    :nine => 9,
    ten: 10,
    jack: 11,
    queen: 12,
    king: 13,
    ace: [1, 14]
  }

  SUITS = [:spades, :clubs, :hearts, :diamonds]

  attr_reader :suit, :type, :val

  def initialize(suit, type)
    @suit = suit
    @type = type
    @val = CARD_VALS[type]
  end
end
