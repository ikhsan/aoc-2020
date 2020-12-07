require 'set'

input = File.readlines('07.txt', chomp: true)

def parse(str, memo = {})
  x = str.split('bags contain')
  container = x[0].strip

  contained = x[1].split(',').map { |x| 
    item = x.gsub(/bags?.?/, '').strip
    q = item[0..1].to_i
    if q > 0
      [q, item[2..-1]]
    else
      nil
    end
  }.compact

  contained.each do |q, col|
    memo[col] = [] if memo[col].nil?
    memo[col] << container
    memo[col].uniq
  end

  memo
end

def count(memo, node)
  res = if memo[node].nil?
    []
  else
    tmp = memo[node]
    memo[node].each { |col|
      tmp += count(memo, col)
    }
    tmp.uniq
  end

  res
end



memo = {}
input = """light red bags contain 1 bright white bag, 2 muted yellow bags.
dark orange bags contain 3 bright white bags, 4 muted yellow bags.
bright white bags contain 1 shiny gold bag.
muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
dark olive bags contain 3 faded blue bags, 4 dotted black bags.
vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
faded blue bags contain no other bags.
dotted black bags contain no other bags.
""".split("\n")
input.each { |line| parse(line, memo) }
res1 = count(memo, 'shiny gold').length

puts '*' * 20
# puts memo
puts res1
puts '*' * 20