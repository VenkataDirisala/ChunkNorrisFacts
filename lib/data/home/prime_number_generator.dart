class PrimeNumberGenerator {
  // Sieve of Erotasfen algorithm to generate prime numbers
  // until N(one of the most optimal algorithms)
  Future<List<bool>> getPrimeNumberList(int end) async {
    final isPrime = List.filled(end + 1, true);

    // one is not prime
    isPrime[1] = false;

    for (int p = 2; p * p <= end; p++) {
      // If prime[p] is not changed, then it is a prime
      if (isPrime[p]) {
        // Update all multiples of p
        for (int i = p * 2; i <= end; i += p) {
          isPrime[i] = false;
        }
      }
    }
    return isPrime;
  }
}
