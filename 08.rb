input = File.readlines('08.txt', chomp: true)
# input = File.readlines('sample.txt', chomp: true)

opcodes = input.map { |l|
  code, num = l.split(' ')
  [code, num.to_i]
}

def part1(opcodes)
  pos = 0
  acc = 0
  check = Array.new(opcodes.length, false)

  loop do
    break if pos >= opcodes.length
    break if check[pos]

    check[pos] = true
    code, num = opcodes[pos]
    if code == 'nop'
      pos += 1
    elsif code == 'acc'
      pos += 1
      acc += num
    elsif code == 'jmp'
      pos += num
    end
  end

  [acc, pos]
end

def toggle(opcode)
  code, num = opcode
  if code == 'nop'
    ['jmp', num]
  elsif code == 'jmp'
    ['nop', num]
  end
end

def part2(opcodes)
  opcodes.each_with_index { |opcode, idx|
    code, num = opcode
    next if code == 'acc'

    mod_opcodes = opcodes.clone
    mod_opcodes[idx] = toggle(mod_opcodes[idx])
    acc, pos = part1(mod_opcodes)

    if (pos >= opcodes.length)
      return [acc, pos]
    end
  }
  
  []
end

res1, _ = part1(opcodes)
res2, _ = part2(opcodes)
puts '*' * 10
puts res1
puts res2
puts '*' * 10