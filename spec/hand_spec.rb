require 'rspec'
require 'hand'

describe Hand do
  let(:card) {double("card", suit: :spades, type: :A, val: [1, 14])}
  let(:two_of_diamonds) {double("card", suit: :diamonds, type: :two, val: 2)}
  let(:three_of_diamonds) {double("card", suit: :diamonds, type: :three, val: 3)}
  let(:four_of_diamonds) {double("card", suit: :diamonds, type: :four, val: 4)}
  let(:five_of_diamonds) {double("card", suit: :diamonds, type: :five, val: 5)}
  let(:six_of_diamonds) {double("card", suit: :diamonds, type: :six, val: 6)}
  let(:cards) {[two_of_diamonds, three_of_diamonds, four_of_diamonds, five_of_diamonds, six_of_diamonds]}
  let(:hand) { Hand.new(cards) }
  let(:ten_of_diamonds) {double("card", suit: :diamonds, type: :ten, val: 10)}
  let(:ten_of_hearts) {double("card", suit: :hearts, type: :ten, val: 10)}
  let(:jack_of_diamonds) {double("card", suit: :diamonds, type: :jack, val: 11)}
  let(:queen_of_diamonds) {double("card", suit: :diamonds, type: :queen, val: 12)}
  let(:king_of_diamonds) {double("card", suit: :diamonds, type: :king, val: 13)}
  let(:ace_of_diamonds) {double("card", suit: :diamonds, type: :ace, val: 14)}
  let(:two_of_diamonds) {double("card", suit: :diamonds, type: :two, val: 2)}
  let(:str_flush) {Hand.new([ten_of_diamonds, jack_of_diamonds, queen_of_diamonds, king_of_diamonds, ace_of_diamonds])}
  let(:four_of_a_kind) {Hand.new([ten_of_diamonds, ten_of_diamonds, ten_of_diamonds, ten_of_diamonds, ace_of_diamonds])}
  let(:full_house) {Hand.new([ten_of_diamonds, ten_of_diamonds, ten_of_diamonds, jack_of_diamonds, jack_of_diamonds])}
  let(:flush) {Hand.new([ten_of_diamonds, two_of_diamonds, king_of_diamonds, jack_of_diamonds, queen_of_diamonds])}
  let(:straight) {Hand.new([ten_of_hearts, ace_of_diamonds, king_of_diamonds, jack_of_diamonds, queen_of_diamonds])}
  let(:three_of_a_kind) {Hand.new([ten_of_hearts, ten_of_hearts, ten_of_hearts, jack_of_diamonds, queen_of_diamonds])}
  let(:two_pair) {Hand.new([ten_of_hearts, ten_of_hearts, jack_of_diamonds, jack_of_diamonds, queen_of_diamonds])}
  let(:one_pair) {Hand.new([ten_of_hearts, ten_of_hearts, king_of_diamonds, jack_of_diamonds, queen_of_diamonds])}
  let(:lower_one_pair) {Hand.new([ten_of_hearts, ten_of_hearts, king_of_diamonds, jack_of_diamonds, six_of_diamonds])}
  let(:high_card) {Hand.new([ten_of_hearts, two_of_diamonds, king_of_diamonds, jack_of_diamonds, queen_of_diamonds])}
  describe '#initialize' do
    it 'intializes with 5 cards in hand' do
      expect(hand.cards.length).to eq (5)
    end
  end

  describe '#add_card' do
    it 'adds a single card' do
      hand.add_card(card)
      expect(hand.cards.length).to eq(6)
    end

    it 'adds multiple cards' do
      3.times { hand.add_card(card) }
      expect(hand.cards.length).to eq(8)
    end
  end

  describe '#remove_card' do
    it 'removes a single card' do
      hand.remove_card(0)
      expect(hand.cards).to eq([three_of_diamonds, four_of_diamonds, five_of_diamonds, six_of_diamonds])
    end
    it 'removes a card from the middle' do
      hand.remove_card(3)
      expect(hand.cards).to eq([two_of_diamonds, three_of_diamonds, four_of_diamonds, six_of_diamonds])
    end
    it 'removes multiple cards' do
      hand.remove_card(3)
      hand.remove_card(1)
      expect(hand.cards).to eq([two_of_diamonds, four_of_diamonds, six_of_diamonds])
    end
  end

  describe '#score' do
    it 'assigns straight flush a score' do
      expect(str_flush.score).to eq(1_000_000_014)
    end
    it 'assigns four of a kind a score' do
      expect(four_of_a_kind.score).to eq(100_000_010)
    end
    it 'assigns full house a score' do
      expect(full_house.score).to eq(10_000_011)
    end
    it 'assigns flush a score' do
      expect(flush.score).to eq(1_000_013)
    end
    it 'assigns straight a score' do
      expect(straight.score).to eq(100_014)
    end
    it 'assigns score to three of a kind' do
      expect(three_of_a_kind.score).to eq(10_010)
    end
    it 'assigns score to two pair' do
      expect(two_pair.score).to eq(1011)
    end
    it 'assigns score to one pair' do
      expect(one_pair.score).to eq(110)
    end
    it 'assigns score to high card' do
      expect(high_card.score).to eq(13)
    end
  end

  describe '#<=>' do
    it 'straight flush beats a flush' do
      expect(str_flush<=>(flush)).to eq(1)
    end
    it 'four of a kind beats a full house' do
      expect(four_of_a_kind<=>(full_house)).to eq(1)
    end
    it 'three_of_a_kind beats a two_pair' do
      expect(three_of_a_kind<=>(two_pair)).to eq(1)
    end
    it 'one_pair beats a high_card' do
      expect(one_pair<=>(high_card)).to eq(1)
    end
    it 'breaks ties' do
      expect(one_pair<=>lower_one_pair).to eq(1)
    end
    it 'returns 0 on ties' do
      expect(one_pair<=>one_pair).to eq(0)
    end
  end
end
