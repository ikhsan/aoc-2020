require 'pp'

file = '19.txt'
# file = 'sample.txt'
input = File.read(file)

raw_rules, messages = input.split("\n\n")

RULES = {}
raw_rules.each_line do |l|
  key, val = l.chomp.split(": ")
  value = if val == '"a"' || val == '"b"'
    val.gsub("\"", '')
  else
    val.split(' | ')
  end
  RULES[key] = value
end

def _get(key)
  rules = RULES[key]
  return [rules] if rules.is_a?(String)

  rules.flat_map do |rule|
    keys = rule.split(" ")

    tmp = get(keys.shift)    
    keys.each do |k|
      tmp = get(k).flat_map do |a|
        tmp.map { |b| b + a }
      end
    end

    tmp
  end
end

MEMO = {}
def get(key)
  if MEMO[key].nil?
    MEMO[key] = _get(key)
  end
  MEMO[key]
end

require 'set'

valid_msgs = Set.new(get('0'))
res1 = messages.split("\n").count { |msg| valid_msgs.member?(msg) }

# Part 2
# taken from: https://www.reddit.com/r/adventofcode/comments/kg1mro/2020_day_19_solutions/ggd6xt5?utm_source=share&utm_medium=web2x&context=3
# My rule 0 = 8 11
# New rule 8 = 42 | 42 42 | 42 42 42 | ...
# New rule 11 = 42 31 | 42 42 31 31 | 42 42 42 31 31 31 | ...
# So, my rule 0 = 42{n} 31{m}, where n>m and m>0

R42 = MEMO['42'].join("|")
R31 = MEMO['31'].join("|")
REGEX = /^((#{R42})+)((#{R31})+)$/

def match(msg)
  match_data = REGEX.match(msg)
  return false if match_data.nil?

  (match_data[1].length / match_data[2].length) > (match_data[3].length / match_data[4].length)
end

res2 = messages.split("\n").count { |msg| match(msg) }

puts '*' * 10
puts res1
puts res2
puts '*' * 10