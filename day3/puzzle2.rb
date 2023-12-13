require_relative 'input'

arr = INPUT.split

# ********************************get symbols****************************

def line_symbols(line)
  line.chars.each_with_index.map { |char, i| i if char.match?(/(\*)/) }.compact
end

# *************** gets numbers and their indexes from line *****************

def potential_engine_parts(line)
  numbers_hash = {}
  l = 'a'
  nums = line.scan(/\d{1,3}/)
  numbers_indexes = line.enum_for(:scan, /\d{1,3}/).map { Regexp.last_match.begin(0) }
  nums.each_with_index do |num, i|
    num_indexes = [numbers_indexes[i]]
    (num.size - 1).times do
      num_indexes << (num_indexes.last + 1) unless num_indexes.empty?
    end
    numbers_hash["#{l}#{num}"] = num_indexes
    l.next!
  end
  numbers_hash
end

# ************ gets numbers from the lines surrounding (*) Symbols *************

def surrounding_numbers(array, index)
  numbers_indexes_array = []
  lines = [array[index - 1], array[index], array[index + 1]]
  lines = [array.first, array[index + 1]] if index.zero?

  lines.each { |line| numbers_indexes_array << potential_engine_parts(line) unless line.nil? }
  numbers_indexes_array
end

# ****************** Checks if parts are gears ************************

def part?(parts, sym)
  is_part = []
  parts.each do |k, val|
    val.each do |i|
      if [sym, sym - 1, sym + 1].include?(i)
        is_part << k[1..].to_i
        break
      end
    end
  end
  is_part.size == 2 ? is_part.reduce(:*) : false
end

# ********************* Apply logic to INPUT ************************

def check_gears(input_arr)
  good_parts = []
  input_arr.each_with_index do |line, i|
    symbols = line_symbols(line)
    parts = surrounding_numbers(input_arr, i).reduce({}, :merge)

    symbols.each do |s|
      good_parts << part?(parts, s) unless part?(parts, s) == false
    end
  end
  good_parts.reduce(:+)
end

p check_gears(arr)
