function [sos,C] = tf2pf(b,a)
% Convert transfer function coefficients into
% parallel form coefficients
[r p C] = residuez(b,a);
np = length(p);
ns = floor(np/2);
pp = cplxpair(p);
ind = zeros(1,np);
for ii = 1:np
ind(ii) = isreal(pp(ii));
end
ind = logical(ind);
pp = [pp(~ind);pp(ind)];
rr = zeros(size(r));
for ii = 1:np
    pind = find(p==pp(ii),1,'first');
    rr(ii) = r(pind);
end
sos = zeros(ns,5);
for jj = 1:ns
    [sos(jj,1:2), sos(jj,3:5)] = ...
        residuez(rr(2*(jj-1)+1:2*jj),pp(2*(jj-1)+1:2*jj),[]);
end
if mod(np,2) == 1
    sos = [sos;[r(end) 0 1 -p(end) 0]];
end
sos = real(sos);
