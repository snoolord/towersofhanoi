class Array
  def remove_dups
    counter = Hash.new
    self.each do |key|
      counter[key] = key
    end
    counter.keys.sort
  end

  def two_sum
    zero_sums = []
    self.each_with_index do |val1, idx1|
      self.each_with_index do |val2, idx2|
          zero_sums << [idx1, idx2] if val1 + val2 == 0 && idx1 < idx2
      end
    end
    zero_sums
  end

  def my_transpose
    rows = self
    cols = Array.new(3) { [] }
    rows.each do |row|
      row.each_with_index do |value, index|
        cols[index] << value
      end
    end
    cols
  end

  def stock_picker
    best_pairs = Hash.new { |hash, key| hash[key] =  [] }
    self.each_with_index do |val1, idx1|
      self.each_with_index do |val2, idx2|

        best_pairs[val2 - val1] << [idx1, idx2] unless idx1 > idx2
        # zero_sums << [idx1, idx2] if val1 + val2 >=  && idx1 < idx2
      end
    end
    best_days = best_pairs[best_pairs.keys.max_by {|key, val| key}]

    best_days = best_days.min_by do |pair|
      pair.last - pair.first
    end
    [best_days]
  end
end

class Hanoi
  attr_accessor :towers

  def initialize
    @towers = [[3, 2, 1], [], []]
  end

  def won?
    self.towers == [[], [], [3, 2, 1]]
    puts "YOU WIN!!!"
  end

  def parse_input(input)
    raise "Please use proper form! \n
    e.g tower_take,tower_give -> 0,2" unless input.include?(",")
    chars = input.split(",")
    chars.delete("")
    raise  "Character input not accepted!" if chars.any? { |char| char =~ /[a-z]/ }
    coords = chars.map(&:to_i)
    raise "You didn't give us two towers!" unless coords.length == 2
    raise "Pick a proper tower! 0..2" if coords.any? { |num| num > 2 || num < 0 }
    coords
  end

  def take_move
    begin
    puts "Input the tower you want to take from and give to.\n
    e.g tower_take,tower_give -> 0,2"
      input = gets
      input = input.chomp
      coord = parse_input(input)
    rescue => e
      print e.message
      retry
    end
    coord
  end

  def move_piece(coord)
    from_tower, to_tower = coord
    p from_tower
    p to_tower
    raise "Cannot pull from empty tower" if @towers[from_tower].empty?
    unless @towers[to_tower].empty?
      raise "Cannot stack onto a smaller value" if @towers[to_tower].last < @towers[from_tower].last
    end
    @towers[to_tower] << @towers[from_tower].pop
    # p @towers
  end

  def play
    until won?
      p @towers
      begin
       coord = take_move
       p coord
       move_piece(coord)
       p @towers
      rescue => e
        print e.message
        retry
      end
    end
  end
end
game = Hanoi.new
game.play
