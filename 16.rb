require 'pp'
file = '16.txt'
# file = 'sample.txt'
input = File.read(file, chomp: true)
nums, tix, tixs = input.split("\n\n")

require 'set'

rules = {}
nums.each_line { |line|
  key, r1, r2 = line.chomp.split(/(?::\s|\sor\s)/)
  r1_start, r1_end = r1.split('-').map(&:to_i)
  r2_start, r2_end = r2.split('-').map(&:to_i)
  rules[key] = [(r1_start..r1_end), (r2_start..r2_end)]
}

def part1(nums, tixs, rules)
  valid = Set.new
  rules.values.flatten.each { |r| valid += Set.new(r) }

  res = 0
  valids = []
  tixs.split("\n").drop(1).each { |l|
    ids = l.split(',').map(&:to_i)
    invalid =  Set.new(ids) - valid
    valids << ids if invalid.empty?
    invalid.each { |id| res += id }
  }

  [res, valids]
end

class PartTwo
  attr_accessor :my_ticket, :rules, :valid_ids, :solution

  def initialize(my_ticket, valid_tickets, rules)
    @my_ticket = my_ticket.split("\n").last.split(',').map(&:to_i)
    @rules = rules.map { |k,v| 
      [k, Set.new(v[0]) + Set.new(v[1])] 
    }.to_h 
    @valid_ids = (0...@my_ticket.length).map do |idx|
      nums = valid_tickets.map { |valid_nums| valid_nums[idx] }
      Set.new(nums)
    end
  end

  def run
    @solution = Array.new(keys.count)
    
    solve
    
    result = 1
    solution.each_with_index do |key, i|
      result *= my_ticket[i] if key.start_with?("departure")
    end
    result
  end

  private def keys
    @keys ||= rules.keys
  end

  private def solve
    return if solution.none? { |x| x.nil? }

    index, possibilities = best_guess
    return if possibilities.empty?

    possibilities.each do |p|
      @solution[index] = p
      solve
      return if solution.none? { |x| x.nil? }

      # backtrack
      @solution[index] = nil
    end
  end

  private def best_guess
    guesses = solution.map.with_index do |val, idx|
      next nil unless val.nil?

      possibilities = keys.select do |k|
        next false if solution.compact.include?(k)
        invalids = valid_ids[idx] - rules[k]
        invalids.empty?
      end

      [idx, possibilities]
    end.compact

    guesses.sort { |a, b| a[1].count <=> b[1].count }.first
  end

end


res1, valids = part1(nums, tixs, rules)
puts res1

p2 = PartTwo.new(tix, valids, rules)
puts p2.run

