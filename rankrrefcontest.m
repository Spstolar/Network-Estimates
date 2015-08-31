%contest between rref and rank

s = 20000;
ranksingular = 0;
rrefsingular = 0;
n = 20;

for i = 1:s  % run this many samples
        
        connMat = double( rand(n,n) < .5);
        
        ranksingular = ranksingular + rankOnesCheck(connMat,n);
        
        rrefsingular = rrefsingular + rrefOnesCheck(connMat,n);


end

ranksingular 
rrefsingular