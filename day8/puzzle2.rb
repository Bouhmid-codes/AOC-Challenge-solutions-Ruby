STR = File.open('./input.txt')

instructions = STR.first.chomp.chars

# ********************** Get maps from Input************************
maps = {}
STR.each_line do |line|
  nodes = line.scan(/\w{3}/)
  maps[nodes[0]] = { 'L' => nodes[1], 'R' => nodes[2] } unless nodes.empty?
end

# ********************** Count steps *******************************
steps = []
start_nodes = []
maps.each_key { |k| start_nodes << k if k.match?(/\w{2}A/) }

start_nodes.each do |item|
  next_val = nil
  counter = 0
  instructions.cycle do |instruction|
    counter += 1
    current_val = maps[next_val].nil? ? maps[item][instruction] : maps[next_val][instruction]
    next_val = current_val
    instructions << instruction
    break if next_val.match?(/\w{2}Z/)
  end
  steps << counter
end
p steps.reduce(1, :lcm)
