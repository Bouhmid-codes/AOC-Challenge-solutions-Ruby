require_relative 'input'

digits = {
  'one' => 'o1e',
  'two' => 't2o',
  'three' => 'thr3ee',
  'four' => 'fo4ur',
  'five' => 'fi5ve',
  'six' => 'si6x',
  'seven' => 'se7ven',
  'eight' => 'ei8ght',
  'nine' => 'ni9ne'
}

arr = INPUT.split

digits.each { |k, v| arr.map! { |str| str.gsub(k, v) } }

arr.map! do |str|
  str.gsub!(/\D/, '')
  str[0] + str[-1]
end
p arr.map(&:to_i).sum
