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
