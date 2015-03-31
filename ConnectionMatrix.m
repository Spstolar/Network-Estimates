function[ x ] = ConnectionMatrix(M, varargin)
%ConnectionMatrix -- input the number of agents follows by who sends info
%to whom
%  M  =  # of agents
% args like [i1 i2 i3 ... in] mean agent i1 is sending info to i2, i3, i4,
% ..., in 
J = length(varargin);
x = connectionsforvertex(varargin{1},M);
for j = 2:J
	x = x + connectionsforvertex(varargin{j},M);
end
end

