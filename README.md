# Network-Estimates Update No.3 7.20.15
Going through to upgrade to more than 3 layers.

# Network-Estimates Update No.2 4.5.15
Working on issue of singular covariance matrix. Have a fix, but it doesn't seem to be stable. One of the main issues with this is determining when the matrix is singular. cond(A) alone doesn't work because the result can be different than Inf and still be inputted singular matrices.

A second issue seems to be happening when delagents.m is used, resulting in a row and column of NaNs. Testing this might be a good first step into seeing what's causing the SVD issue.

~Simon


# Network-Estimates Update No.1 4.5.15

To run trials of what the final estimates are going to be, we do not need the connect matrix codes.

We use 
  1. RandArray.m which generates an array of distinct random integers
  2. ConnectGen.m randomly assigned the desired number of connection leaving agents for the inputted layers
  3. ConnectionTester.m uses 1., 2., and NetEst2.m to run a bunch of trials of random agents in order to return a histogram of what the error distribution for connects looks like.
