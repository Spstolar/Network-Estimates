function[C, L] = TestConnectionMatrix(A)
L = zeros(1,3);
[L(1), L(2)] = size(A);
L(3) = 1;
totalagents = sum(L);
C = zeros(totalagents, totalagents);
C(totalagents,L(1)+1:totalagents-1) = ones(1,L(2));

