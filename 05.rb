input = File.readlines('05.txt', chomp: true)

def seat_id(s)
  row_str = s[0..6]
  col_str = s[7..9]

  # find row
  start, finish = 0, 127
  row_str.each_char { |r|
    mid = (start + finish) / 2
    
    if r == 'F'
      finish = mid
    elsif r == 'B'
      start = mid + 1
    end
  }
  row = start
  
  # find col
  start, finish = 0, 7  
  col_str.each_char { |c|
    mid = (start + finish) / 2

    if c == 'L'
      finish = mid
    elsif c == 'R'
      start = mid + 1
    end
  }
  col = start

  row * 8 + col
end

ids = input.map { |i| seat_id(i) }
res1 = ids.max # 935

res2 = nil
ids.sort.each_cons(2) { |a,b|
  if b - a != 1
    res2 = a + 1
  end
}


puts '*' * 50
puts res1
puts res2
puts ids.sort
puts '*' * 50