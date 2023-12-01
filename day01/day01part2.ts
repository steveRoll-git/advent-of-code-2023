const numberNames = [
  "one",
  "two",
  "three",
  "four",
  "five",
  "six",
  "seven",
  "eight",
  "nine",
];

let sum = 0;

for (const line of Deno.readTextFileSync("input")
  .split("\n")
  .filter((l) => l)) {
  const firstDigitR = line.match(/\d/)!;
  let firstDigitIndex = firstDigitR.index!;
  let firstDigit = firstDigitR[0];

  const lastDigitR = line.match(/(\d)[^\d]*$/)!;
  let lastDigitIndex = lastDigitR.index!;
  let lastDigit = lastDigitR[1];

  for (const [value, name] of numberNames.entries()) {
    const first = line.indexOf(name);
    if (first != -1 && first < firstDigitIndex) {
      firstDigitIndex = first;
      firstDigit = String(value + 1);
    }
    const last = line.lastIndexOf(name);
    if (last != -1 && last > lastDigitIndex) {
      lastDigitIndex = last;
      lastDigit = String(value + 1);
    }
  }

  sum += Number(firstDigit + lastDigit);
}

console.log(sum);
