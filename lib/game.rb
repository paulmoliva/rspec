require_relative 'player.rb'
require_relative 'hand.rb'

class Game
  attr_reader :deck, :pot, :players

  def initialize(deck, players)
    @deck = deck
    @players = players
  end

  def deal
    deck.shuffle!
    h1 = []
    h2 = []
    5.times {h1 << deck.pop!}
    5.times {h2 << deck.pop!}
    hand1 = Hand.new(h1)
    hand2 = Hand.new(h2)
    player_one.get_hand(hand1)
    player_two.get_hand(hand2)
  end

  def show
    puts "Player One: "
    player_one.show
    puts "Player Two: "
    player_two.show
  end

  def get_winner
    case (player_one.hand <=> player_two.hand)
    when 1
      winner = player_one
      puts 'Player One wins'
    when 0
      winner = nil
      puts 'Tie!'
    when -1
      winner = player_two
      puts 'Player Two wins'
    end
    winner
  end


  private
  def player_one
    players.first
  end

  def player_two
    players.last
  end

end

if __FILE__ == $PROGRAM_NAME
  deck = Deck.new
  p1 = Player.new(deck)
  p2 = Player.new(deck)
  game = Game.new(deck, [p1,p2])
  game.deal
  # game.show
  draw_amt = p1.get_draw_amt
  p1.get_draw(draw_amt)
  p1.take(draw_amt)
  game.show
  game.get_winner
end
