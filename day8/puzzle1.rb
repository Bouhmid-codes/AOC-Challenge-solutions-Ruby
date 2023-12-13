STR = File.open('./input.txt')

instructions = STR.first.chomp.chars

# ********************** Get maps from Input************************
maps = {}
STR.each_line do |line|
  nodes = line.scan(/\w{3}/)
  maps[nodes[0]] = { 'L' => nodes[1], 'R' => nodes[2] } unless nodes.empty?
end

# ********************** Count steps *******************************

counter = 0
first = maps['AAA']
next_val = nil

instructions.each do |instruction|
  counter += 1
  current_val = maps[next_val].nil? ? first[instruction] : maps[next_val][instruction]
  next_val = current_val
  instructions << instruction
  break if next_val
end
p counter
