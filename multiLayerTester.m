function[ x ] = multiLayerTester( L , k )


filename = strcat('wiringTests\\',num2str(L),'.txt');


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