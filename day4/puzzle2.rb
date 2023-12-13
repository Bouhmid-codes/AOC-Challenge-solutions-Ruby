require_relative 'input'
# require 'pry-byebug'

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

# *********************** wins per card hash ***********************************

def wins_per_card(input)
  wins_hash = Hash.new(0)
  input.each_with_index do |line, i|
    numbers = numbers(line)
    wins = check_matches(numbers)
    wins_hash[i] = wins
  end
  wins_hash
end

# *********************** instances hash ***********************************

def result_hash
  hash = {}
  209.times do |n|
    hash[n] = 1
  end
  hash
end

# *********************** fills instances hash ***********************************

def total(input_hash)
  hash = result_hash
  hash.each do |k, val|
    val.times do
      next_key = k + 1
      (input_hash[k]).times do
        hash[next_key] += 1
        next_key += 1
      end
    end
  end
  hash.values.sum
end

p total(wins_per_card(input_arr))
