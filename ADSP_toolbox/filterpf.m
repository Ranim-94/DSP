function y = filterpf(sos,C,x)
% Implements parallel form according to (9.31)
Lx = length(x);
x = [0 x];
LC = length(C);
K = size(sos,1);
y = zeros(K+1,Lx+2);
for k = 1:K
    for n = 1:Lx
        y(k,n+2) = sos(k,1)*x(n+1) + sos(k,2)*x(n) ...
            - sos(k,4)*y(k,n+1) - sos(k,5)*y(k,n);
    end
end
if LC > 2
    x = [zeros(1,LC-2) x];
elseif LC == 1
    x(1) = [];
end
for n = 1:Lx
    for jj = 1:LC
    y(end,n+2) = y(end,n+2) + C(jj)*x(n+LC-jj);
    end
end
y = sum(y(:,3:end),1);