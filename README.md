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
6->3->10->5->16->8->4->2->1
```
Key Concepts in this Program:
* Total stopping time: The number of steps needed to reach 1 for a given starting number.
* This program finds the starting number in a given range that has the largest total stopping time.
* For very large numbers, intermediate values may exceed standard integer limits, which can cause overflow warnings.
