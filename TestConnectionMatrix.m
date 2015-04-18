function[C, neterror] = TestConnectionMatrix(A)
L = zeros(1,3);
[L(1), L(2)] = size(A);
L(3) = 1;
sum(A(1,:))
sum(A(2,:))
sum(A(3,:))
totalagents = sum(L);
C = zeros(totalagents, totalagents);
C(totalagents,L(1)+1:totalagents-1) = ones(1,L(2));
C(L(1)+1:L(1)+L(2),1:L(1)) = transpose(A);
[I,neterror]  = NetEst(C,L);
