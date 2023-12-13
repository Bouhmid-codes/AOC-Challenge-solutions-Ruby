require_relative 'input'

input_array = INPUT.split(' ')

# scan indexes of the numbers in the current string in an array

def potential_engine_parts(line)
  numbers_hash = {}
  l = 'a'
  nums = line.scan(/\d{1,3}/)
  nums.each do |num|
    num_indexes = []
    num_indexes << i = line.index(num)
    line.sub!(line[i..(i + (num.size - 1))], '.' * num.size)
    (num.size - 1).times do
      num_indexes << (i += 1)
    end
    numbers_hash["#{l}#{num}"] = num_indexes
    l.next!
  end
  numbers_hash
end

# scan indexes of the symbols in surrounding lines

def line_symbols(line)
  line.chars.each_with_index.map { |char, i| i unless char.match?(/(\.|\d)/) }.compact
end

def surrounding_symbols(array, index)
  symbols_indexes_array = []
  lines = [array[index - 1], array[index], array[index + 1]]
  lines = [array.first, array[index + 1]] if index.zero?

  lines.each { |line| symbols_indexes_array << line_symbols(line) unless line.nil? }
  symbols_indexes_array.flatten
end

# test each number (digit indexes) against the symbols indexes and select valid engine parts

def part?(part, symbols)
  is_part = false
  symbols.each do |s|
    part.each { |v| is_part = true if [s, s - 1, s + 1].include?(v) }
    break if is_part == true
  end
  is_part
end

# Apply logic to each line of the INPUT

def check_parts(input_arr)
  good_parts = []
  input_arr.each_with_index do |line, i|
    parts = potential_engine_parts(line)
    symbols = surrounding_symbols(input_arr, i)
    parts.each { |k, v| good_parts << k[1..].to_i if part?(v, symbols) }
  end
  good_parts.reduce(:+)
end

p check_parts(input_array)
