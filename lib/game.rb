require_relative 'player.rb'
require_relative 'computer_player.rb'
require_relative 'hand.rb'
require 'io/console'

class Game
  attr_reader :deck, :pot, :players

  def initialize(deck, players)
    @deck = deck
    @players = players
    @pot = 0
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
    system("clear")
    puts "Your hand: "
    sleep(0.5)
    player_one.show
    puts "Computer player's hand: "
    sleep(2)
    player_two.show
    puts "current pot: $#{pot}"
  end

  def get_winner
    case (player_one.hand <=> player_two.hand)
    when 1
      winner = player_one
      puts "You win $#{@pot}"
    when 0
      winner = nil
      puts 'Tie!'
    when -1
      winner = player_two
      puts "Computer player wins $#{@pot}"
    end
    pay_winnings(winner)
    winner
  end

  def play_draw_turns
    players.each {|p| p.play_draw_turn} unless @players.any?{|p| p.folded}
  end

  def run
    round = 0
    loop do
      if player_one.bankroll < 25
        puts "You can't afford the ante! You're broke!"
        break
      elsif player_two.bankroll < 100
        player_two.bankroll += 1000
        puts "computer player takes another $1,000 out of the bank!"
      end
      play_turn(round)
      round += 1
    end
  end


  def play_turn(round)
    reset_round
    deal
    ante_up
    play_bet_turn(round)
    play_draw_turns
    play_bet_turn(round + 1)
    show unless folded?
    get_winner
    continue
  end

private

def folded?
  players.any?{|p| p.folded}
end

  def continue
    puts "your bankroll is $#{players[0].bankroll}"
    puts "Press any key to continue."
    STDIN.getch
  end

  def play_bet_turn(round)
    system("clear")
    original_round = round
    2.times do
      return if players.any?{|p| p.folded} || players.any?{|p| p.bankroll == 0}
      turn = round % 2
      turn == 0 ? other_player = 1 : other_player = 0
      puts "Player #{turn + 1}'s turn: " if round == original_round
      puts "Player #{turn + 1}: Raise?" if round != original_round
      amt = players[turn].get_bet
      if amt >= players[other_player].bankroll
        players[turn].bankroll += (amt - players[other_player].bankroll)
        amt = players[other_player].bankroll
        all_in_call = true
      end
      unless amt == 0
        puts "Player #{turn + 1} raised the stakes!" if round != original_round
        puts "Player #{other_player + 1}'s turn: "
        puts "WARNING: Calling will put you all in!" if all_in_call
        amt += players[other_player].call_bet(amt)
      else
        puts "Check!"
      end
      @pot += amt
      round += 1
    end
    system("clear")
  end

  def reset_round
    players.each{|p| p.folded = false}
    players.each do |p|
      5.times{p.discard(0) unless p.hand.nil? || p.hand.cards.empty?}
    end
    system("clear")
  end

  def player_one
    players.first
  end

  def player_two
    players.last
  end

  def ante_up
    puts "paying $25 ante!"
    players.each{|p| p.bet(25)}
    @pot += 50
  end

  def pay_winnings(winner)
    if winner.nil?
      players.each{|p| p.bankroll += pot / 2}
    else
      winner.bankroll += pot
  end
    @pot = 0
  end
end

def play
  deck = Deck.new
  p1 = Player.new(deck)
  p2 = ComputerPlayer.new(deck)
  game = Game.new(deck, [p1,p2])
  game.run
end

if __FILE__ == $PROGRAM_NAME
  play
  puts "Play Again? Y/N"
  ans = STDIN.getch
  play unless ans == 'n'
end
