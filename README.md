# Network-Estimates Update 4.5.15

To run trials of what the final estimates are going to be, we do not need the connect matrix codes.

We use 
  1. RandArray.m which generates an array of distinct random integers
  2. ConnectGen.m randomly assigned the desired number of connection leaving agents for the inputted layers
  3. ConnectionTester.m uses 1., 2., and NetEst2.m to run a bunch of trials of random agents in order to return a histogram of what the error distribution for connects looks like.
