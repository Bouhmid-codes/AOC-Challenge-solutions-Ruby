require_relative 'input'

# ************************** PART 2 ***********************************

# Scans game string for matches and returns an array of hashes for each play

def scan(str)
  str.split(';').map do |sub_game|
    sub_arr = sub_game.scan(/(\d+)\s(\w+)/).map(&:reverse).flatten
    Hash[*sub_arr].transform_keys(&:to_sym).transform_values(&:to_i)
  end
end

# takes each game, filters the minimum cubes needed and returns the power of the set

def minimum_cubes_per_game(game)
  minimums_cubes = { red: 0, green: 0, blue: 0 }

  game.each do |sub_game|
    sub_game.each do |k, v|
      minimums_cubes[k] = v if minimums_cubes[k] < v
    end
  end
  minimums_cubes.values.reduce(:*)
end

sum = 0

INPUT.each_value do |val|
  game = scan(val)
  sum += minimum_cubes_per_game(game)
end

puts sum
