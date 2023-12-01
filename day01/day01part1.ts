let sum = 0;

for (const line of Deno.readTextFileSync("input")
  .split("\n")
  .filter((l) => l)) {
  const firstDigit = line.match(/.*?(\d)/)!;
  const lastDigit = line.match(/.*(\d)/)!;
  sum += Number(firstDigit[1] + lastDigit[1]);
}

console.log(sum);
