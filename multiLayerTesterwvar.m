function[ x , avgvardiff ] = multiLayerTesterwvar( L , k )


Lstring = '';
for i = 1:length(L)-1
    Lstring = strcat(Lstring,num2str(L(i)),'-');
end

Lstring = strcat(Lstring,'1');

filename = strcat('multi',Lstring,'.txt');


fileID = fopen(filename,'w');
fprintf(fileID,strcat('The layout is ', Lstring, '.\n'));

[ x, opt, nonopt, skipped, avgvardiff ] = checkrandomwiringswvar(L,k);

formatSpec = 'The percentage of optimal wirings is %3.4f.\n';
fprintf(fileID,formatSpec,x);
fprintf(fileID,'Skipped %hd \n', skipped);
fprintf(fileID,'Optimal: %hd \n',opt);
fprintf(fileID,'Nonoptimal: %hd \n',nonopt);
fprintf(fileID,'Average extra variance: %3.4f.\n',avgvardiff);
fclose(fileID);

end