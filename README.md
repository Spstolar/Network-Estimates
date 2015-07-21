# Structure
NetEst takes a connection matrix and the layer breakdown vector and outputs the variance of the final estimate along with the info matrix encoding howmuch of the top layer estimates each agent is using (reported in the first L(1) entries of the column).
  Uses: singcheck - to determine whether or not a given matrix is singular
        desing - to remove a minimum number of columns and rows so that the resulting matrix is nonsingular.
        
ConnectionMatrix takes the total number of agents and the vectors encoding the flow of info and turns it into a connection matrix, reducing the amount of typing/entry to product a connection matrix.
  Uses: connectionsforvertex - takes a vector which encodes who the first entry agent sends info to and the total number of agents M and turns this into the matrix which is empty except for the column corresponding to that agent.
        


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
