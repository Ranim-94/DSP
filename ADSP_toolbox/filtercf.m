function y = filtercf(sos,G,x)
% Implements IIR cascade form given in Figure 9.11
% and equation (9.28)
Lx = length(x);
K = size(sos,1);
y = G*x;
w = zeros(1,Lx+2);
for k = 1:K
    for n = 1:Lx
        w(n+2) = -sos(k,5)*w(n+1)-sos(k,6)*w(n)+y(n);
        y(n) = sos(k,1)*w(n+2)+sos(k,2)*w(n+1)+sos(k,3)*w(n);
    end
end
