function[ x ] = connectionsforvertex( a , M)
% takes a vector which encodes who the first entry agent sends info to and
% the total number of agents M and turns this into the matrix which is
% empty except for the column corresponding to that agent.
% [3 5 8] means agent 3 sends info to agents 5 and 8.

x = zeros(M,M);
[~, N] = size(a);
for k = 2:N
    x(a(k),a(1)) = 1;
end
end