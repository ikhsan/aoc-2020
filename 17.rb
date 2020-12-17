require 'pp'

file = 'sample.txt'
file = '17.txt'
input = File.readlines(file, chomp: true).map { |l| l.split('') }

ACTIVE = '#'
INACTIVE = '.'

def get(cubes, x, y, z)
  depth = cubes.length
  height = cubes[0].length
  width = cubes[0][0].length

  return '.' if (x < 0 || y < 0 || z < 0)
  return '.' if (x >= width || y >= height || z >= depth)
  
  cubes[z][y][x]
end

ADJS = [
  [-1,-1, -1], [0,-1, -1], [1,-1, -1],
  [-1, 0, -1], [0, 0, -1], [1, 0, -1],
  [-1, 1, -1], [0, 1, -1], [1, 1, -1],

  [-1,-1, 0], [0,-1, 0], [1,-1, 0],
  [-1, 0, 0], [0, 0, 0], [1, 0, 0],
  [-1, 1, 0], [0, 1, 0], [1, 1, 0],

  [-1,-1, 1], [0,-1, 1], [1,-1, 1],
  [-1, 0, 1], [0, 0, 1], [1, 0, 1],
  [-1, 1, 1], [0, 1, 1], [1, 1, 1],
]
def count(cubes, x, y, z)
  res = 0
  ADJS.reject { |x,y,z| x == 0 && y == 0 && z == 0 }
  .each do |dx,dy,dz| 
    res += 1 if get(cubes, x+dx, y+dy, z+dz) == ACTIVE
  end
  res
end

def next_state(cubes, x, y, z)
  cube = get(cubes, x, y, z)
  actives = count(cubes, x, y, z)

  res = if cube == ACTIVE && (actives != 2 && actives != 3)
    INACTIVE
  elsif cube == INACTIVE && (actives == 3)
    ACTIVE
  else
    cube
  end
  
  res
end

def print_cubes(cubes)
  cubes.each_with_index { |d, i|
    puts "level #{i}"
    puts d.map { |l| l.join('') }.join("\n")
    puts ""
  }
end

def get4d(cubes, x, y, z, w)
  space = cubes.length
  depth = cubes[0].length
  height = cubes[0][0].length
  width = cubes[0][0][0].length

  return '.' if (x < 0 || y < 0 || z < 0 || w < 0)
  return '.' if (x >= width || y >= height || z >= depth || w >= space)

  cubes[w][z][y][x]
end

def count4d(cubes, x, y, z, w)
  adjs = ADJS.flat_map { |x| 
    [-1, 0, 1].map { |y| 
      x.clone + [y] 
    } 
  }.reject { |x,y,z,w| 
    x == 0 && y == 0 && z == 0 && w == 0 
  }

  res = 0
  adjs.each do |dx,dy,dz,dw| 
    res += 1 if get4d(cubes, x+dx, y+dy, z+dz, w+dw) == ACTIVE
  end
  res
end

def next_state4d(cubes, x, y, z, w)
  cube = get4d(cubes, x, y, z, w)
  actives = count4d(cubes, x, y, z, w)

  res = if cube == ACTIVE && (actives != 2 && actives != 3)
    INACTIVE
  elsif cube == INACTIVE && (actives == 3)
    ACTIVE
  else
    cube
  end
  
  res
end

def print_cubes4d(cubes)
  cubes.each_with_index { |d, i|
    d.each_with_index { |c, j|
      puts "z=#{j} w=#{i}"
      puts c.map { |l| l.join('') }.join("\n")
      puts ""
    }
  }
end

# Part 1
curr = [input]
res = 0
6.times do |i|
  depth = curr.length
  height = curr[0].length
  width = curr[0][0].length

  cubes = Array.new(depth + 2) { 
    Array.new(height + 2) {
      Array.new(width + 2) { "." }
    } 
  }

  res = 0
  for z in -1..depth do
    for y in -1..height do
      for x in -1..width do
        cube = next_state(curr, x, y, z)
        cubes[z+1][y+1][x+1] = cube
        res += 1 if cube == ACTIVE
      end
    end
  end

  curr = cubes.clone.map { |col| col.clone.map(&:clone) }
end

# Part 2
curr4d = [[input]]

res4d = 0
6.times do |i|
  space = curr4d.length
  depth = curr4d[0].length
  height = curr4d[0][0].length
  width = curr4d[0][0][0].length

  cubes = Array.new(space + 2) {
    Array.new(depth + 2) { 
      Array.new(height + 2) {
        Array.new(width + 2) { "." }
      } 
    }
  }

  res4d = 0
  for w in -1..space do
    for z in -1..depth do
      for y in -1..height do
        for x in -1..width do
          cube = next_state4d(curr4d, x, y, z, w)
          cubes[w+1][z+1][y+1][x+1] = cube
          res4d += 1 if cube == ACTIVE
        end
      end
    end
  end

  curr4d = cubes.clone.map { |dep| dep.clone.map { |col| col.clone.map(&:clone) } }
end

puts '*' * 10
# print_cubes(curr)
puts(res)

# print_cubes4d(curr4d)
puts res4d
puts '*' * 10

