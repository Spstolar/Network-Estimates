function[ C ] = convertToConnection( bInt, numRec, numSend )
% takes a binary integer and uses its dimensions (to account for beginning
% zeros) and coverts it to a numRec x numSend matrix

C = zeros(1,numSend*numRec);
totalentries = numSend*numRec;

for i = 1:totalentries
    digit = totalentries - i +1;
    C(digit) = mod(bInt,10);
    bInt = floor(bInt/10);
end

C = reshape(C, [numRec, numSend]);