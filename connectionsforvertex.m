function[ x ] = connectionsforvertex( a , M)
x = zeros(M,M);
a(1);
[O N] = size(a);
for k = 2:N
    x(a(k),a(1)) = 1;
end
end