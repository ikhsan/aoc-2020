let fs = require('fs');

function twoSum(input, expected, startIndex) {
  let i = startIndex
  let j = input.length - 1
  while (i <= j) {
    let added = input[i] + input[j]
    if (added === expected) {
      return [input[i],input[j]]
    } else if (added > expected) {
      j--
    } else {
      i++
    }
  }
  return []
}

function threeSum(input, expected) {
  input.sort((a,b) => a - b)

  for (let idx = 0; idx < input.length - 2; idx++) {
    let toFind = expected - input[idx]

    let res = twoSum(input, toFind, idx + 1)

    let found = res.length !== 0
    if (found) {
      return res.concat([input[idx]])
    }
  }

  return []
}

function main() {
  let input = fs.readFileSync('01.txt', 'utf8')
    .split("\n")
    .map(i => parseInt(i))
    .sort((a,b) => a - b);

  let res1 = twoSum(input, 2020, 0).reduce((a,b) => a*b);
  let res2 = threeSum(input, 2020).reduce((a,b) => a*b);
  console.log('***************');
  console.log(res1);
  console.log(res2);
  console.log('***************');
};
main();