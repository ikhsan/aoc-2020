input = File.readlines('13.txt', chomp: true)

min_start = now = input[0].to_i
buses = input[1].split(',').map(&:to_i).select { |x| x != 0 } 

bus = nil
loop do
  bus = buses.find { |x| now % x == 0 }
  break unless bus.nil?
  now += 1
end

puts '*' * 10
puts (now - min_start) * bus
puts '*' * 10

def part2(input, start = 1)
  seq = input.split(',').map.with_index do |val, idx|
    next nil if val == 'x'
    [val.to_i, idx]
  end.compact

  t = 1
  stepper = 1
  seq.each do |p, off|
    loop do
      break if (t + off) % p == 0
      t += stepper
    end

    stepper = stepper.lcm(p)
    puts "[#{p},#{off}] now=#{t}, step=#{stepper}"
  end

  return t
end

# puts part2("17,x,13,19") # is 3417.
# puts part2("67,7,59,61") # is 754018.
# puts part2("67,x,7,59,61") # is 779210.
# puts part2("67,7,x,59,61") # is  1261476.
# puts part2("7,13,x,x,59,x,31,19") # is 1068788
# puts part2("1789,37,47,1889", 636_400) # is 1202161486

puts part2(input[1])
puts '*' * 10

