function[x] = sing(A)

x = (cond(A) == inf) | (abs(cond(A)) < 10^-10) | (cond(A) > 10^10);