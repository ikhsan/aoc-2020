require 'pp'

input = File.readlines('18.txt', chomp: true)

def eval(str)
  tokens = str.split(' ')

  curr = get_operand(tokens)  
  loop do
    break if tokens.empty?

    operator = get_operator(tokens)
    operand = get_operand(tokens)

    curr = if operator == "+"
      curr + operand
    elsif operator == "*"
      curr * operand
    end    
  end

  curr
end

def numeric?(str)
  return true if str =~ /\A\d+\Z/
  true if Float(str) rescue false
end

def get_operand(tokens)
  return tokens.shift.to_i if numeric?(tokens.first)
  unless tokens.first.start_with?('(')
    pp tokens
    raise "invalid operand" 
  end

  open_p = 0
  operands = []
  loop do
    op = tokens.shift
    operands << op
    open_p += op.count("(")
    open_p -= op.count(")")

    break if tokens.empty?
    break if open_p == 0
  end

  expr = operands.join(' ')[1...-1]
  eval(expr)
end

def get_operator(tokens)
  op = tokens.shift
  raise "invalid operator" if op != "+" && op != "*"
  op
end

def get_raw_operand(tokens)
  return tokens.shift    if numeric?(tokens.first)
  unless tokens.first.start_with?('(')
    pp tokens
    raise "invalid operand" 
  end

  # parentheses
  open_p = 0
  operands = []
  loop do
    op = tokens.shift
    operands << op
    open_p += op.count("(")
    open_p -= op.count(")")

    break if tokens.empty?
    break if open_p == 0
  end

  operands.join(' ')
end

# taken from https://apidock.com/rails/Array/split
def split(array, value)
  arr = array.map(&:clone)
  res = []
  while (idx = arr.index(value))
    res << arr.shift(idx)
    arr.shift
  end
  res << arr
end

def transform(str)
  raw_tokens = str.split(" ")

  tokens = [get_raw_operand(raw_tokens)]
  loop do
    break if raw_tokens.empty?
    tokens << get_operator(raw_tokens)
    tokens << get_raw_operand(raw_tokens)
  end

  tokens = tokens.map { |x| _transform(x) }
  tokens = split(tokens, "*")
  tokens.map { |t| "(#{t.join(' ')})" }.join(" * ")
end

def _transform(x)
  return x if numeric?(x)
  return x if x == "+" || x == "*"

  "(#{transform(x[1...-1])})"
end


def eval2(str)
  transformed = transform(str)
  eval(transformed)
end


# puts eval("1 + 2 * 3 + 4 * 5 + 6") # becomes 71
# puts eval2("1 + 2 * 3 + 4 * 5 + 6") # becomes 231

# puts eval('1 + (2 * 3) + (4 * (5 + 6))') # becomes 51
# puts eval2("1 + (2 * 3) + (4 * (5 + 6))") # becomes 51

# puts eval('2 * 3 + (4 * 5)') # becomes 26.
# puts eval2("2 * 3 + (4 * 5)") # becomes 46

# puts eval('5 + (8 * 3 + 9 + 3 * 4 * 3)') # becomes 437.
# puts eval2("5 + (8 * 3 + 9 + 3 * 4 * 3)") # becomes 1445

# puts eval('5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))') # becomes 12240.
# puts eval2("5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))") # becomes 669060

# puts eval('((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2') # becomes 13632
# puts eval2("((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2") # becomes 23340

part1 = input.map { |expr| eval(expr) }.reduce(:+)
part2 = input.map { |expr| eval2(expr) }.reduce(:+)

puts '*' * 10
puts part1
puts part2
puts '*' * 10

# Taken too much time in part 2 to insert brackets in the correct place
# 
