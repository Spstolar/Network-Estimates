function [ x ] = NetEst1( C, L)
%NetEst1 Calculting estimates given the connection matrix, and for now
%assuming equal variance of 1 for the top layer.
N = sum(L)
I = zeros(N,N);
K = length(L);
y = sym('y');

%the matrix whose column i tell you who agent i receives info from
R = transpose(C);

%define the info matrix for the top layer
for k = 1:L(1)
    I(k,k) = 1;
end

%define the info matrix for the second layer
for k = 1:L(2)
    for j = 1:N
        I(j,k + L(1)) = R(j ,k+L(1))./sum(R(:,k+L(1)));
    end
end

x = I;

end

