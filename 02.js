let fs = require('fs');

let input = fs.readFileSync('02.txt', 'utf8')
    .split("\n");

function validate(s) {
  let [range, char, pass] = s.split(' ')
  let [start, finish] = range.split('-').map(x => parseInt(x))
  
  let charCount = pass.split('').filter(x => x === char[0]).length

  return start <= charCount && charCount <= finish
}

function validate2(s) {
  let [range, char, pass] = s.split(' ')
  let [i, j] = range.split('-').map(x => parseInt(x) - 1)

  return (pass[i] === char[0] ^ pass[j] === char[0]) === 1;
}

console.log("*****")
console.log(input.filter(validate).length)
console.log(input.filter(validate2).length)
console.log("*****")