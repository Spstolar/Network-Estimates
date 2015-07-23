function[ x ] = threeLayerCheck( L )

fileID = fopen('threelayerresult.txt','w');
formatSpecHeader = 'The layout is %1.0f - %1.0f - %1.0f.\n';
fprintf(fileID,formatSpecHeader,L(1),L(2),L(3));

[ x, opt, nonopt, totalruns, skipped ] = checkallwirings(L);

formatSpec = 'The percentage of optimal wirings is %3.4f.\n';
fprintf(fileID,formatSpec,x);
fprintf(fileID,'Total %hd \n', totalruns);
fprintf(fileID,'Skipped %hd \n', skipped);
fprintf(fileID,'Optimal: %hd \n',opt);
fprintf(fileID,'Nonoptimal: %hd \n',nonopt);
fclose(fileID);

end