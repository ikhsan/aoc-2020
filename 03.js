let fs = require('fs');

let maps = fs.readFileSync('03.txt', 'utf8')
    .split("\n");

const TREE = '#';

function countTrees(maps, r, d) {
  let width = maps[0].length;
  let height = maps.length;

  let count = 0;
  let [x, y] = [0, 0];
  while (true) {
    if (maps[y][x] === TREE) {
      count += 1;
    }

    x = (x + r) % width;
    y = y + d;

    if (y >= height) {
      break;
    }
  }
  return count;
}

function checkSlopes(maps) {
  let slopes = [
    [1, 1],
    [3, 1],
    [5, 1],
    [7, 1],
    [1, 2],
  ];

  return slopes
    .map(slope => {
      let [r,d] = slope;
      return countTrees(maps, r,d);
    })
    .reduce((acc, val) => acc * val)
}

console.log("*********************");
console.log(countTrees(maps, 3, 1));
console.log(checkSlopes(maps));
console.log("*********************");
