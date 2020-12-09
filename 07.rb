input = File.readlines('sample.txt', chomp: true)
# input = File.readlines('07.txt', chomp: true)

graph = {}
i_graph = {}

Bag = Struct.new(:q, :color)

input.each { |l|
  bag, content_str = l.split(' bags contain ')
  contents = content_str.split(/ bags?[.,]/).map { |c|
    c = c.strip
    q = c[0..1].to_i
    next nil if q == 0
    Bag.new(q, c[2..])
  }.compact
  
  # contained
  graph[bag] = contents

  # contained_by
  contents.each {|b| 
    i_graph[b.color] = [] if i_graph[b.color].nil?
    i_graph[b.color] << bag
  }
}

def count(graph, bag_color)
  return [] if graph[bag_color].nil?

  res = graph[bag_color]
  graph[bag_color].each { |color|
    res += count(graph, color)
  }
  res.uniq
end

def count2(graph, bag_color)
  return 0 if graph[bag_color].empty?

  res = 0
  graph[bag_color].each { |bag| 
    res += bag.q + bag.q * count2(graph, bag.color)
  }
  res
end

res1 = count(i_graph, 'shiny gold').count
res2 = count2(graph, 'shiny gold')
puts '*' * 20
puts (res1 == 121) ? "🎉" : "💔 (#{res1})"
puts (res2 == 3805) ? "🎉" : "💔 (#{res2})"
puts '*' * 20