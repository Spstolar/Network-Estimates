%this will determine what percentage of nxn random matrices of random 0/1
%entries are nonsingular
s = 20000;
singular = 0;
nonsingamount = zeros(1,40);
p = .05:.05:1;

for j = 1:20
    for n = 1:40
        for i = 1:s  % run this many samples
            
            connMat = double( rand(n,n) < p(j));
            
            if (rank(connMat) < n)
                singular = singular + 1;
            end
        end
        
        nonsingamount(n) = 1 - singular/s
        singular = 0;
        
        
    end
    
    figs(j) = figure;
    scatter(1:40, nonsingamount)
    title(strcat('p = ',num2str(p(j))))
    xlabel('square matrix size')
    ylabel('nonsingular probability')
    print(strcat('p = ',num2str(p(j))),'-dpdf')
end

