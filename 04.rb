input = File.read('04.txt')

sample = """
ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
byr:1937 iyr:2017 cid:147 hgt:183cm

iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
hcl:#cfa07d byr:1929

hcl:#ae17e1 iyr:2013
eyr:2024
ecl:brn pid:760753108 byr:1931
hgt:179cm

hcl:#cfa07d eyr:2025 pid:166559648
iyr:2011 ecl:brn hgt:59in
"""

def validate(pass)
  keys = [
    'byr',
    'iyr',
    'eyr',
    'hgt',
    'hcl',
    'ecl',
    'pid',
  ]

  data = pass.split(' ').map { |d|
    kv = d.split(':')
    [kv[0], kv[1]]
  }.to_h

  count = 0
  keys.each { |k|
    count +=1 if data.key?(k)
  }
  count == keys.count
end

def validate_yr(input, start, finish)
  yr = input.to_i
  (start..finish).include?(yr)
end

def validate_hgt(input)
  if input.include?('cm')
    return (150..193).include?(input.to_i)
  end
  
  if input.include?('in')
    return (59..76).include?(input.to_i)
  end

  false
end

def validate_hcl(input)
  res = (input =~ /#[A-Fa-f0-9]{6}/)
  !res.nil?
end

def validate_ecl(input)
  %w(amb blu brn gry grn hzl oth).include?(input)
end

def validate_pid(input)
  !(input =~ /^\d{9}$/).nil?
end

def validate2(pass)
  return false unless validate(pass)

  data = pass.split(' ').map { |d|
    kv = d.split(':')
    [kv[0], kv[1]]
  }.to_h

  return false unless validate_yr(data["byr"], 1920, 2002)
  return false unless validate_yr(data["iyr"], 2010, 2020)
  return false unless validate_yr(data["eyr"], 2020, 2030)
  return false unless validate_hgt(data["hgt"])
  return false unless validate_hcl(data["hcl"])
  return false unless validate_ecl(data["ecl"])
  return false unless validate_pid(data["pid"])

  true
end

pass = input.split("\n\n")
res1 = pass.count { |p| validate(p) }
res2 = pass.count { |p| validate2(p) }

puts '*' * 30
puts res1
puts res2
puts '*' * 30