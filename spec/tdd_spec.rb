require 'rspec'
require 'tdd'

describe Array do
  let(:empty_array) {[]}
  let(:array_one) {[1,2,3,3,3,4,5]}
  let(:array_two) {[-1,0,2,-2,1]}
  let(:array_2_5) {[-2,2,2,2,-3,3]}
  let(:array_three) {[
    [1,2,3],
    [4,5,6],
    [7,8,9]
    ]}
  describe '#my_uniq' do
    it 'removes duplicates' do
      expect(array_one.my_uniq).to eq ([1,2,3,4,5])
    end
    it 'does not change the original array' do
      expect(array_one.my_uniq).not_to be (array_one)
    end
  end

  describe '#to_sum' do
    it 'returns [] when called on an empty array' do
      expect(empty_array.to_sum).to eq ([])
    end
    it 'returns [] when there are no matching pairs' do
      expect(array_one.to_sum).to eq ([])
    end
    it 'returns correct index pairs' do
      expect(array_two.to_sum).to eq [[0,4], [2,3]]
    end
    it 'sorts dictionary-wise' do
      expect(array_2_5.to_sum).to eq([[0,1], [0,2], [0,3], [4,5]])
    end
  end

  describe '#my_transpose' do
    it 'returns an empty array when called on empty array' do
      expect(empty_array.my_transpose).to eq ([])
    end

    it 'properly transpose a 3 x 3 matrix' do
      expect(array_three.my_transpose).to eq ([
        [1,4,7],
        [2,5,8],
        [3,6,9]
        ])
    end

    it 'does not change the original array' do
      expect(array_three.my_transpose).not_to be (array_three)
    end
  end

  describe 'stock picker' do
    let(:weird_prices) {[1,1,2,3,4,1,4,7,5,4]}
    let(:tricky_prices) {[1,2,7,0]}
    let(:prices) {[23,35,36,27,50]}

    it 'returns nil if length is less than 2' do
      expect([1].stock_picker).to eq nil
    end
    it 'outputs the most profitable set of pairs' do
      expect(prices.stock_picker).to eq ([0,4])
    end
    it 'outputs the later buy day when there is an earlier day with the same low price' do

      expect(weird_prices.stock_picker).to eq [5,7]
    end
    it "doesn't try to buy after the sell date" do

      expect(tricky_prices.stock_picker).to eq [0,2]
    end
  end
end
