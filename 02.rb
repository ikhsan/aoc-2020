input = File.readlines('02.txt', chomp: true)

def validate(s)
  range, char, pass = s.split(' ')
  start, finish = range.split('-').map(&:to_i)

  res = pass.count(char[0])
  (start..finish).member?(res)
end

def validate2(s)
  range, char, pass = s.split(' ')
  i,j = range.split('-').map { |x| x.to_i - 1 }

  (pass[i] == char[0]) ^ (pass[j] == char[0])
end

puts "*" * 20
puts input.count { |x| validate(x) }
puts input.count { |x| validate2(x) }
puts "*" * 20