require_relative 'input'
require 'pry-byebug'

input_arr = INPUT.split(/\n/)

# *********************** Get numbers from the card ***************************

def numbers(line)
  line.gsub(/Card\s+\d{1,3}:/, '').split('|').map { |part| part.scan(/\d{1,2}/) }
end

# *********************** Checks for matches ***********************************

def check_matches(numbers)
  wins = 0
  winning_numbers = numbers.first
  my_numbers = numbers.last
  my_numbers.each do |num|
    wins += 1 if winning_numbers.include?(num)
  end
  wins
end

# *********************** calculates points per card ***********************************

def calculate_points(wins)
  return 0 if wins.zero?

  score = 1

  wins -= 1
  wins.times do
    score *= 2
  end
  score
end

# *********************** calculates total points ***********************************

def total(input)
  win_arr = 0
  input.each do |line|
    numbers = numbers(line)
    wins = check_matches(numbers)
    win_arr += calculate_points(wins)
    # binding.prybb
  end
  win_arr
end

p total(input_arr)
