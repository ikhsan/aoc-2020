# input = File.readlines('sample.txt', chomp: true)
input = File.readlines('12.txt', chomp: true)

EAST, SOUTH, WEST, NORTH = 0, 1, 2, 3

x, y = 0,0
dir = EAST

input.each_with_index do |line, idx|
  letter = line[0]
  num = line[1..].to_i

  case letter
  when 'E'
    x += num    
  when 'S'
    y += num
  when 'W'
    x -= num
  when 'N'
    y -= num
  when 'F'
    case dir
    when EAST
      x += num
    when SOUTH
      y += num
    when WEST
      x -= num
    when NORTH
      y -= num      
    end
  when 'R'
    dir = (dir + (num / 90)) % 4
  when 'L'
    dir = (dir - (num / 90)) % 4
  end
end

puts '*' * 20
puts x.abs + y.abs
puts '*' * 20

x, y = 0,0
wx, wy = 10, -1

def rotate(num, x, y)
  if num == 180
    [-x, -y]
  elsif num == 90
    [-y, x]
  elsif num == 270
    [y, -x]
  else
    [x, y]
  end
end

input.each_with_index do |line, idx|
  letter = line[0]
  num = line[1..].to_i

  case letter
  when 'E'
    wx += num    
  when 'S'
    wy += num
  when 'W'
    wx -= num
  when 'N'
    wy -= num    
  when 'R'
    wx, wy = rotate(num, wx, wy)
  when 'L'
    wx, wy = rotate(360 - num, wx, wy)
  when 'F'
    x = x + num * wx
    y = y + num * wy
  end

  puts "#{idx}  #{x},#{y} #{wx},#{wy}"
end

puts '*' * 20
puts x.abs + y.abs
puts '*' * 20




