function cph=contphase(grd,om)
% Computation of continuous phase function
% from equidistant values of group delay
N=length(om);
dom=om(2)-om(1);
p(1)=0;
for k=2:N
    p(k)=p(k-1)+dom*(grd(k-1)+grd(k))/2;
end
cph=-p;