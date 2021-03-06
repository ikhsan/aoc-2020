maps = File.readlines('03.txt', chomp: true)

TREE = '#'

def slope(maps, r, d)
  width = maps[0].length
  height = maps.length
  
  count = 0
  x,y = [0,0]
  loop do
    count += 1 if maps[y][x] == TREE

    x = (x + r) % width
    y = y + d

    break if y >= height
  end
  
  count
end

def main(maps)
  steps = [
    [1, 1],
    [3, 1],
    [5, 1],
    [7, 1],
    [1, 2],
  ]

  steps.map { |r, d| slope(maps, r, d) }.reduce(1, :*)
end

puts "*" * 20
puts slope(maps, 3, 1)
puts main(maps)
puts "*" * 20

