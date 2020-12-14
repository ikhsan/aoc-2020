# input = File.readlines('sample.txt', chomp: true)
input = File.readlines('14.txt', chomp: true)


def set_mask(str)
  res = {}
  str.reverse.each_char.with_index do |v, i|
    next if v == 'X'
    res[i] = v.to_i
  end
  res
end

def apply(val, mask)
  res = val
  mask.each { |k,v| 
    next if res[k] == v
    
    # from: https://stackoverflow.com/a/41274825
    if v == 1
      # Setter—only works setting to 1, not to 0
      res = res | 1 << k
    elsif v == 0
      # Setter—set to 0
      res = res - (1 << k)
    end
  }
  res
end

def part1(input)
  mem = {}
  mask = {}

  for line in input do
    com, val = line.split(' = ')
    if com == 'mask'
      mask = set_mask(val)
    elsif com[0..2] == 'mem'
      addr = com.delete("^0-9").to_i
      # puts ">> apply #{mask}"
      i = apply(val.to_i, mask)
      # puts ">> #{val} > #{i}"
      
      # puts "set #{i} to address #{addr}"
      mem[addr] = i
    end
  end
  
  mem.values.reduce(:+)
end

puts '*' * 10
puts part1(input)

require 'pp'
def subset(nums)
  return [0] if nums.empty?

  last = nums.pop
  prev_set = subset(nums)

  prev_set + prev_set.map(&:clone).map { |set| 
    set + last
  }
end

def apply_addr(mask, addr)
  tmp = mask.clone
  xs = []
  mask.each_char.with_index { |c, i|
    inv_i = mask.length - 1 - i
    if c == '0'
      tmp[i] = addr[inv_i].to_s
    else
      xs << 2 ** inv_i if tmp[i] == 'X'
      tmp[i] = c
    end
  }
  
  base = tmp.gsub('X', '0').to_i(2)
  # puts ("%036b" % addr)
  # puts mask.gsub(/[X1]/, '.')
  # puts tmp.gsub(/[X1]/, '.')
  # puts ''

  subset(xs).map { |x| base + x }
end

def part2(input)
  mem = {}
  mask = ''

  for line in input do
    com, val = line.split(' = ')
    if com == 'mask'
      mask = val
    elsif com[0..2] == 'mem'
      addr = com.delete("^0-9").to_i
      addrs = apply_addr(mask, addr)
      
      addrs.each { |a| mem[a] = val.to_i}
    end
  end
  
  # pp mem
  mem.values.reduce(0, :+)
end

# Bitten again by ruby's reference values!
# array or string should be cloned 
# instead of just using it as it is

# 2662888623651
# 3564822193820
puts part2(input)
puts '*' * 10