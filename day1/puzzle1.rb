require_relative 'input'

arr = INPUT.split.map { |item| item.chars.select { |char| char.match?(/\d/) }.join }

arr.map! { |item| "#{item[0]}#{item[-1]}".to_i }

p arr.sum
