let fs = require('fs');

function validate(pass) {
  let data = pass.replace(/\n/g, ' ').split(' ')
    .reduce((o, v) => {
      let [key, val] = v.split(':');
      o[key] = val;
      return o;
    }, {});

  return ['byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid']
    .every(k => k in data);
}

function main() {
  let input = fs.readFileSync('04.txt', 'utf8');
  let pass = input.split("\n\n");

  let res = pass.filter(p => validate(p)).length;
  console.log('***************');
  console.log(res);
  console.log('***************');
}

main();
