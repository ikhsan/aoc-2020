nums = File.readlines('01.txt', chomp: true).map(&:to_i)

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

def three_sum(nums, expected)
  a = nums.sort

  for i in 0..a.length-3 do
    v1 = a[i]
    target = expected - v1

    sub_a = a[(i + 1)..a.length]
    ab = two_sum(sub_a, target)
    if !ab.empty?
      v2,v3 = ab
      return [v1, v2, v3]
    end
  end
  
  []
end

res1 = two_sum(nums, 2020).reduce(:*)
res2 = three_sum(nums, 2020).reduce(:*)
puts '*' * 50
puts res1
puts res2
puts '*' * 50