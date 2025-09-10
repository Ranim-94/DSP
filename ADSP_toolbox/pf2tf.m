function [b,a] = pf2tf(sos,C)
% Convert parallel form coefficients into direct form coefficients
n = size(sos,1);
r = zeros(2*n,1);
p = zeros(2*n,1);
for ii = 1:n
    [r(2*(ii-1)+1:2*ii) p(2*(ii-1)+1:2*ii) k] = ...
        residuez(sos(ii,1:2),sos(ii,3:5));
end
ind = p ~= 0;
p = p(ind);
r = r(ind);
[b,a] = residuez(r,p,C);
b = real(b);
a = real(a);