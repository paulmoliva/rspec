class TowerHanoi
  attr_accessor :towers

  def initialize
    @towers = [
      [1,2,3],
      [nil, nil, nil],
      [nil, nil, nil]
    ]
  end

  def move(from, to)
    raise Exception if towers[from].all?(&:nil?)
    raise Exception if from == to
    i = 0
    while towers[from][i].nil?
      i += 1
    end
    j = 2
    until towers[to][j].nil?
      j -= 1
    end
    unless towers[to].all?(&:nil?)
      raise Exception if towers[to][j+1] < towers[from][i]
    end
    towers[to][j] = towers[from][i]
    towers[from][i] = nil
  end

  def won?
    towers[1..2].any?{|el| el == [1,2,3]}
  end
end
