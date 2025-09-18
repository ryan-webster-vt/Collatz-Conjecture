# Collatz Conjecture

The **Collatz Conjecture**, sometimes called the 3n + 1 problem, is a fascinating unsolved puzzle in mathematics. Here’s how it works:

1. Pick any positive integer `n`.
2. Keep applying these rules until `n` equals 1:
   - If `n` is even, divide it by 2 (`n → n/2`).
   - If `n` is odd, multiply by 3 and add 1 (`n → 3n + 1`).

The conjecture claims that no matter what positive integer you start with, you’ll always end up at 1.

### Example
Starting with `n = 6`:
6 -> 3 -> 10 -> 5 -> 16 -> 8 -> 4 -> 2 -> 1

## About This Program
- **Total Stopping Time**: The number of steps it takes to reach 1 from a given starting number.
- **Purpose**: This program finds the starting number within a specified range that has the longest total stopping time.
- **Note**: For very large numbers, intermediate values might exceed standard integer limits, potentially causing overflow warnings.

Instructions to Run without Docker
* Install a C compiler
Windows
* Install MinGW-w64 or TDM-GCC
* Make sure `gcc` is in your system PATH. Test with:
```bash
gcc -version
```
Linux
```bash
sudo apt update
sudo apt install build-essential
```
Mac
```bash
xcode-select --install
```

* Clone the Repository
```bash
git clone https://github.com/ryan-webster-vt/Collatz-Conjecture.git
cd collatz
```

* Run the Program
Replace M and N with your desired range of starting numbers.
```bash
./collatz.exe 1 1000
```
* Example Output
```yaml
A starting value between 1 and 1000 (inclusive)
  having the largest total stopping time is 871
  which has 178 steps
Number of start values that result in overflow = 0
elapsed time = 0.01 seconds
```

Instructions to Run with Docker
* Install Docker
* Lauch Docker
* Ensure Docker is running. Test with:
```bash
docker --version
```
* Create Image
```bash
docker build -t collatz-app .
```
* Run Container
```bash
docker run --rm collatz-app M N
```
Replace M and N with integer range


