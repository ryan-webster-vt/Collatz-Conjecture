# Collatz-Conjecture
The **Collatz Conjecture**, also known as the 3n + 1 problem, is a famous unsolved problem in mathematics. It is defined as follows:
  1. Start with any positive integer `n`
  2. Repeat the following steps until n becomes 1:
     - If n is even, divide it by 2 (`n -> n/2`)
     - If n is odd, multiply it by 3 and add 1 (`n -> 3*n + 1`)
The conjecture states that no matter which positive integer you start with, you will always reach 1.
    
Example:
```bash
Start with n = 6:
6 -> 3 -> 10 -> 5 -> 16 -> 8 -> 4 -> 2 -> 1
```
Key Concepts in this Program:
* Total stopping time: The number of steps needed to reach 1 for a given starting number.
* This program finds the starting number in a given range that has the largest total stopping time.
* For very large numbers, intermediate values may exceed standard integer limits, which can cause overflow warnings.

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
git clone https://github.com/username/collatz.git
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
