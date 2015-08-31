function[ y ] = rankOnesCheck( A, n )
%n is the number of columns of A
%this returns 1 if the vector of 1s is in the rowspace of A and 0 otherwise

if (rank(A) < rank([A; ones(1,n)]))
    y = 0;
else
    y = 1;
end