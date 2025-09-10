function [x]=persegen(xp,Np,Nps)
% Generates periodic sequence starting at n=0
% function [x]=persegen(xp,Np,Nps)
%   xp=signal segment to be repeated; 
%   Np=fundamental period (>= length(xp))
%  Nps=number of periods
%  Dimitris Manolakis, March 2005
%  A better version can be obtained using repmat

xp=xp(:); Np = max(Np,length(xp));
xp=[xp ;zeros(Np-length(xp),1)];
xp = repmat(xp,Nps,1); x = xp;