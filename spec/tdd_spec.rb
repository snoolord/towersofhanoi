require "rspec"
require "tdd"

describe Array do
  describe "#remove_dups" do
    let(:a) {[2, 1, 1, 3, 3]}
    it "removes duplicates from array" do
      expect(a.remove_dups).to match_array [2, 1, 3]
    end

    it 'returns sorted array without duplicates' do
      expect(a.remove_dups).to eq([1, 2, 3])
    end

    it 'does not call the Array#uniq method' do
      expect_any_instance_of(Array).not_to receive(:uniq)
      a.remove_dups
    end
  end

  describe "#two_sum" do
    let(:b) {[-1, 0, 2, -2, 1]}

    it "returns an array" do
      expect(b.two_sum.class).to eq(Array)
    end

    it "does not include duplicates" do
      expect(b.two_sum).not_to include([4, 0], [3, 2])
    end

    it "returns pairs of indexes who's value sum to zero" do
      expect(b.two_sum).to eq([[0, 4], [2, 3]])
    end
  end

  describe "#my_transpose" do
    let(:t) {
      [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8]
      ]
    }
    it 'does not called Array#transpose' do
      expect(t.my_transpose).not_to receive(:transpose)
    end

    it "makes rows into columns and columns into rows" do
      expect(t.my_transpose).to eq([[0, 3, 6], [1, 4, 7], [2, 5, 8]])
    end
  end

  describe '#stock_picker' do
    let(:stock_prices) { [1, 5, 3, 1, 10, 13] }

    it 'returns the best pair of days to buy then sell' do
      expect(stock_prices.stock_picker).to include([3,5] || [0,5])
    end
    it 'prefers days with shorter time in between' do
      expect(stock_prices.stock_picker).to eq([[3,5]])
    end
  end
end

describe Hanoi do
  subject(:game) { Hanoi.new }
  # let(:win_game) { double("win_game", :towers => [[], [], [3, 2, 1]])}
  let(:input) { double("input", :coord => 's,2')}
  describe '#initialize' do
    it "game initializes towers correctly" do
      expect(game.towers).to eq([[3, 2, 1], [], []])
    end
  end

  describe '#won?' do
    it 'correctly determines when the game is won' do
      game.towers = [[], [], [3, 2, 1]]
      expect(game.won?).to eq(true)
    end
  end

  describe '#take_move' do

  end

  describe '#parse_input' do
    it 'raises an error for invalid character input' do
      expect { game.parse_input(input.coord) }.to raise_error("Character input not accepted!")
    end

    it 'raises an error if no comma is provided' do
      expect {game.parse_input("00")}.to raise_error
    end

    it 'raises an error if range if outside of towers' do
      expect {game.parse_input("5, 5")}.to raise_error
    end

    it 'raises an error if only one tower is passed in' do
      expect { game.parse_input(",2")}.to raise_error
    end

  end

  describe '#move_piece' do
    before {game.towers = [[3, 2], [1], []]}

    
    it 'raises an error if the first tower is empty' do
      expect { game.move_piece( [2, 1] ) }.to raise_error
    end
    it 'raises an error if the second tower has a smaller value than the incoming piece' do
      expect { game.move_piece( [0, 1] )}.to raise_error
    end
  end

end
