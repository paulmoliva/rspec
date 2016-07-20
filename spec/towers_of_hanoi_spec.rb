require 'rspec'
require "towers_of_hanoi"

describe TowerHanoi do
  let(:tower) { TowerHanoi.new }

  describe '#initialize' do
    it 'creates three arrays for the board' do
      expect(tower.towers.length).to eq(3)
    end

    it 'creates three arrays correctly' do
      expect(tower.towers).to eq([
        [1,2,3],
        [nil,nil,nil],
        [nil,nil,nil]
        ])
    end
  end

  describe '#move!' do
    it 'moves a disc on first move' do
      tower.move(0,1)
      expect(tower.towers).to eq [
        [nil, 2, 3],
        [nil,nil,1],
        [nil, nil, nil]
      ]
    end

    it 'doesnt put big discs on small discs' do
      expect do
              tower.move(0,1)
              tower.move(0,1)
            end.to raise_error

    end

    it "doesn't move to the same tower" do
      expect{tower.move(0,0)}.to raise_error
    end

  end

  describe '#won?' do
    it 'detects a win a row 2' do
      tower.towers = [
        [nil, nil, nil],
        [1,2,3],
        [nil, nil, nil]
      ]
      expect(tower.won?).to be_truthy
    end
    it 'detects a win a row 3' do
      tower.towers = [
        [nil, nil, nil],
        [nil, nil, nil],
        [1,2,3]
      ]
      expect(tower.won?).to be_truthy
    end
  end

end
