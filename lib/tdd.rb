class Array
  def my_uniq
    result = []
    self.each{|el| result << el unless result.include?(el)}
    result
  end

  def to_sum
    result = []
    (0...length).each do |i|
      (i+1...length).each do |j|
        result << [i,j] if self[i] + self[j] == 0
      end
    end
    result
  end

  def my_transpose
    result = Array.new(length) { Array.new(0) }
    (0...length).each do |i|
      (0...length).each do |j|
        result[i] << self[j][i]
      end
    end
    result
  end

  def stock_picker
    return nil if length < 2
    lowest_price = self[0]
    lowest_day = 0
    highest_price = self[0]
    highest_day = 0
    self.each_with_index do |price, day|
      if price > highest_price
        highest_price = price
        highest_day = day
      end
    end
    self.each_with_index do |price, day|
      if price <= lowest_price && day < highest_day
        lowest_price = price
        lowest_day = day
      end
    end
    # highest_profit = 0
    # self.each_with_index do |el, i|
    #   if el > highest_price
    #     highest_day = i
    #     highest_price = el
    #   elsif el <= lowest_price && i < highest_day
    #     lowest_day = i
    #     lowest_price = el
    #   end
    # end
    [lowest_day, highest_day]
    # (0...length).each do |i|
    #   (i+1...length).each do |j|
    #     if self[i] - self[j] >= highest_profit
    #       lowest_day = i
    #       highest_day = j
    #       highest_profit = self[i] - self[j]
    #     end
    #   end
    # end
    # [lowest_day, highest_day]
  end
end
