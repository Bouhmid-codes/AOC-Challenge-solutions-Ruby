require_relative 'input'

# ************************** PART 1 ***********************************
CRITERIA = {
  red: 12,
  green: 13,
  blue: 14
}

# Scans game string for matches and returns an array of hashes for each play

def scan(str)
  str.split(';').map do |sub_game|
    sub_arr = sub_game.scan(/(\d+)\s(\w+)/).map(&:reverse).flatten
    Hash[*sub_arr].transform_keys(&:to_sym).transform_values(&:to_i)
  end
end

# Checks if the game is possible and returns a Boolean

def game_possible?(game)
  is_valid = true
  game.each do |sub_game|
    sub_game.each do |k, v|
      is_valid = false && break if v > CRITERIA[k]
    end
    break if is_valid == false
  end
  is_valid
end

sum = 0

INPUT.each do |k, val|
  game = scan(val)
  sum += k.to_s.to_i if game_possible?(game)
end

puts sum
