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

### Prerequisites
1. Install Docker
2. Ensure Docker is running. Test with:
```bash
docker --version
```
### Steps
1. Clone the repository (if not already done)
2. Build the Docker image:
```bash
docker build -t collatz-app .
```
3. Run the container, replacing M and N with your range:
```bash
docker run --rm collatz-app M N
```
## Notes
* Use positive integers for M and N, ensuring M ≤ N.
* Large ranges may slow down execution or risk overflow with big intermediate values.


