# input = File.readlines('10.txt', chomp: true).map(&:to_i).sort
input = File.readlines('sample.txt', chomp: true).map(&:to_i).sort

def part1(input)
  hash = {}
  input.each_cons(2) { |a,b|
    diff = b - a
    hash[diff] = 0 if hash[diff].nil?
    hash[diff] += 1
  }
  hash[1] +=1 #from 0
  hash[3] +=1 #to highest+3
  hash[1] * hash[3]
end

def part2(input)
  hash = Hash.new(0)
  hash[0] = 1

  input.each do |i|
    hash[i] = hash[i - 1] + hash[i - 2] + hash[i - 3]
  end

  hash[input.last]
end

def part2_b(input)
  arr = [0] + input
  tmp = [0, 0, 1]

  arr.each_cons(2) do |a,b|
    diff = b - a - 1
    tmp.shift(diff)
    tmp = tmp + Array.new(diff, 0)

    sum = tmp.sum
    tmp.shift(1)
    tmp << sum
  end
  tmp.last
end

# res1 = part1(input)
res2 = part2(input)
puts '*' * 10
# puts res1
puts res2
puts part2_b(input)
puts '*' * 10
