## Markov Chains

import math

## Runs the Markov chain with given probablity matrix and initial state for the given number of rounds
## For example the matrix
## [ 1.0  0.9 ]
## [ 0.0  0.1 ]
## and the initial state
## [ 0.5 ]
## [ 0.5 ]
## Run for 3 rounds would be
## ```
##   run([1.0, 0.9, 0.0, 0.1], [0.5, 0.5], 3)
## ```
## And results in the following output
## @[
##   @[0.5, 0.5],
##   @[0.95, 0.05],
##   @[0.995, 0.005]
## ]
proc run*(matrix: openarray[float]; initial: openarray[float]; num_rounds: int): seq[seq[float]] =
  assert(sqrt(matrix.len().float()) mod 1 == 0) # Assert the probability matrix is a square
  let dim = sqrt(matrix.len().float()).int() # Get the number of rows/columns of the matrix
  assert(initial.len() == dim)
  result.add(@initial) # The first round is just the inital state
  for i in 1..<num_rounds: # Each round
    result.add(newSeq[float](dim)) # Add a 'row' to the result
    for j in 0..<dim:
      for k in 0..<dim: # Do the matrix multiplication with the result of the last round
        result[i][j] += matrix[j*dim + k] * result[i-1][k]