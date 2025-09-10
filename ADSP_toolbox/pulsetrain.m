function [x,n] = pulsetrain(N0,Np,N,n0)
% Generate a pulse train
% function [x,n] = pulsetrain(N0,Np,N,n0)
%  x = Pulse train signal
%  n = Timing information vector
% N0 = Number of unit samples in the rectangular pulse
% Np = Fundamental period
%  N = Number of samples in x
% n0 = Starting index
% Copyright 2011: Applied Digital Signal Processing (Manolakis & Ingle)

xp=[ones(N0,1);zeros(Np-N0,1)]; % One period of the pulse train
[x,n]=persegen(xp,Np,N,n0);     % Create Periodic extension