require 'set'

input = File.readlines('07.txt', chomp: true)

Bag = Struct.new(:q, :name)

graph = {}
i_graph = {}
input.each { |l|
  bag, con = l.split(' bags contain ')
  con_bags = con.split(/ bags?[.,]/).map { |con_bag| 
    con_bag = con_bag.strip
    next nil if con_bag == 'no other'
    Bag.new(con_bag[0..1].to_i, con_bag[2..])
  }.compact
  
  # containing
  graph[bag] = con_bags
  
  # contained
  con_bags.each { |con_bag|
    set = i_graph[con_bag.name]
    set = Set.new([]) if set.nil?
    set << bag
    i_graph[con_bag.name] = set
  }
}

def count(graph, expected)
  return Set.new([]) if graph[expected].nil?

  res = Set.new(graph[expected])
  graph[expected].each { |bag| 
    res += count(graph, bag)
  }
  res
end

def count2(graph, bag)
  return 0 if graph[bag].empty?

  graph[bag].reduce(0) { |acc, bag|
    acc + bag.q + bag.q * count2(graph, bag.name)
  }
end

# puts graph
# puts i_graph

res1 = count(i_graph, 'shiny gold').count
res2 = count2(graph, 'shiny gold')

puts '*' * 20
puts res1
puts res2
puts '*' * 20
