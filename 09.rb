input = File.readlines('09.txt', chomp: true).map(&:to_i)
# input = File.readlines('sample.txt', chomp: true).map(&:to_i)

def two_sum(nums, expected)
  a = nums.sort

  low, hi = 0, a.length - 1
  while low < hi
    v1, v2 = a[low], a[hi]
    added = v1 + v2
    if added < expected
      low += 1
    elsif added > expected
      hi -= 1
    else
      return [v1, v2]
    end
  end

  []
end

def part1(input, preamble)
  input.each_cons(preamble + 1) { |nums|
    check = two_sum(nums[0..preamble], nums.last)
    return nums.last if check.empty?
  }
  return -1
end

def part2(input, expected)
  for i in 0...input.length do
    sum = 0
    for j in i...input.length do
      sum += input[j]
      if sum == expected
        return input[i..j]
      elsif sum > expected
        break
      end
    end
  end

  return []
end

def part2_2(input, target)
  return [] if input.length < 2
  
  i = 0
  j = 1
  loop do
    sum = input[i..j].sum 
    if sum < target
      j += 1
    elsif sum > target
      i += 1
    else sum == target
      return input[i..j]
    end

    break if i >= j || j >= input.length
  end
  []
end


res1 = part1(input, 25)
# cont_nums = part2(input, res1)
cont_nums = part2_2(input, res1)
res2 = cont_nums.max + cont_nums.min

puts '*' * 10
puts res1
puts res2
puts '*' * 10