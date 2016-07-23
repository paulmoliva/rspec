require 'colorize'

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
    ace: 14
  }
  CARD_VAL_SYMS = {
    :two => "2",
    :three =>"3",
    :four => "4",
    :five => "5",
    :six => "6",
    :seven => "7",
    :eight => "8",
    :nine => "9",
    ten: "10",
    jack: "J",
    queen: "Q",
    king: "K",
    ace: "A"
  }

  SUITS = [:spades, :clubs, :hearts, :diamonds]

  SUIT_SYM = {
    spades: "♠",
    clubs: "♥",
    hearts: "♦",
    diamonds: "♣",
  }

  SUIT_COLORS = {
    spades: :black,
    clubs: :black,
    hearts: :red,
    diamonds: :red
  }

  attr_reader :suit, :type, :val

  def initialize(suit, type)
    @suit = suit
    @type = type
    @val = CARD_VALS[type]
  end


  # puts "   ".colorize( :background => :white)
  def print_suit
    " #{SUIT_SYM[@suit]}  ".colorize(SUIT_COLORS[@suit]).colorize(:background => :white) + " "
  end
  def print_type
    @type == :ten ? buff = '' : buff = " "
    " #{CARD_VAL_SYMS[@type]} ".colorize(SUIT_COLORS[@suit]).colorize(:background => :white) + buff.colorize(:background => :white) + " "
  end

  def str_output_helper(n, str)
    until str.length == n
      str << " "
    end
    return str
  end
  # puts "   ".colorize( :background => :white)

end
