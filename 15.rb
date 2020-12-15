input = File.readlines('15.txt').first.split(',').map(&:to_i)

require 'pp'
def part1(input)
  mem = input.map.with_index { |v, i| [v, [i+1]] }.to_h

  curr = input.last  
  for i in input.length+1..30_000_000 do
    first = mem[curr].length < 2
    if first
      curr = 0
    else
      curr = mem[curr][0] - mem[curr][1]
    end

    mem[curr] = [] if mem[curr].nil?
    mem[curr].unshift(i)
    # cut since we only need 2 numbers
    mem[curr] = mem[curr].first(2)

    # puts "#{i} > #{curr}" if i % 3_000_000 == 0
  end

  curr
end

puts part1(input)