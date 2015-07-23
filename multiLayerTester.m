function[ x ] = multiLayerTester( L , k )


filename = strcat('wiringTests\\',int2str(L(1)),'-',int2str(L(2)),'-',int2str(L(3)),'w',int2str(k),'.txt');


fileID = fopen(filename,'w');
fprintf(fileID,strcat('The layout is ', L, '.\n'));

[ x, opt, nonopt, skipped ] = checkrandomwirings(L,k);

formatSpec = 'The percentage of optimal wirings is %3.4f.\n';
fprintf(fileID,formatSpec,x);
fprintf(fileID,'Skipped %hd \n', skipped);
fprintf(fileID,'Optimal: %hd \n',opt);
fprintf(fileID,'Nonoptimal: %hd \n',nonopt);
fclose(fileID);

end