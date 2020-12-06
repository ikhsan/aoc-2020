input = File.read('06.txt')
group = input.split("\n\n")

def count(grp)
  grp.split('').select { |g| g.match?(/[a-z]/) }.uniq.length
end

def count2(grp)
  grp.split("\n")
    .reduce(nil) { |acc, val|
      answers = val.split('')
      acc.nil? ? answers : acc & answers
    }
    .count
end

res1 = group.map { |g| count(g) }.reduce(:+)
res2 = group.map { |g| count2(g) }.reduce(:+) 

puts '*' * 20
puts res1 
puts res2
puts '*' * 20