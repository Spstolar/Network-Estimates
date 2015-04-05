function[x] = delagent(C, i)

C(:,i) = [];
C(i,:) = [];

x = C;