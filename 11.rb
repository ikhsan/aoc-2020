input = File.readlines('11.txt', chomp: true)
# input = File.readlines('sample.txt', chomp: true)

EMPTY = 'L'
FLOOR = '.'
OCCUPIED = '#'

def get_seat(input, x, y)
  h = input.length
  w = input.first.length
  return nil if x >= w || x < 0
  return nil if y >= h || y < 0

  input[y][x]
end

def set_seat(input, x, y, val)
  h = input.length
  w = input.first.length
  return if x >= w || x < 0
  return if y >= h || y < 0

  input[y][x] = val
end

def count_adj_occupied(input, x, y)
  h = input.length
  w = input.first.length

  adj = [
    [-1, -1], [0, -1], [1, -1],
    [-1, 0],           [1, 0],
    [-1, 1], [0, 1], [1, 1],
  ]

  adj.count { |dir| 
    first_seen_seat(input, x, y, dir) == OCCUPIED
  }
end

def first_seen_seat(input, x, y, dir)
  vx, vy = dir

  step = 1
  loop do
    val = get_seat(input, x+(step * vx), y+(step * vy))

    return nil if val == nil
    return val if val == OCCUPIED || val == EMPTY

    step += 1
  end
  
  nil
end

def cycle(curr_seat)
  next_seat = curr_seat.clone.map(&:clone)

  for y in 0...curr_seat.length do
    for x in 0...curr_seat[y].length do 
      val = get_seat(curr_seat, x, y)
      next if val == FLOOR
  
      count = count_adj_occupied(curr_seat, x, y)
      if val == EMPTY && count == 0
        set_seat(next_seat, x, y, OCCUPIED)
      elsif val == OCCUPIED && count >= 5
        set_seat(next_seat, x, y, EMPTY)
      end
    end  
  end

  next_seat
end

def seat_equals(a, b)
  for i in 0..a.length do
    return false if a[i] != b[i]
  end
  true
end

def count_occupied(input)
  res = 0
  for str in input do
    str.each_char { |c|
      res += 1 if c == OCCUPIED
    }
  end
  res
end


curr_seat = input.clone.map(&:clone)
loop do
  next_seat = cycle(curr_seat)
  same = seat_equals(curr_seat, next_seat)
  break if same
  curr_seat = next_seat
end

puts count_occupied(curr_seat)


