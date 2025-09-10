function [Nz,Dz] = z2z(Nw,Dw,NT,DT)
% Frequency band Transformation from w-domain to z-domain
% function [Nz,Dz] = z2z(Nw,Dw,NT,DT)
% Nz = Numerator of the resulting digital filter (z-domain)
% Dz = denominator of te resuting digital filter (z-domain)
% Nw = Numerator of the prototype lowpass filter (w-domain)
% Dw = Denominator of the prototype lowpass filter (w-domain)
% NT = Numerator of the transformation
% DT = Denominator of the transformation 
%

Nzord = (length(Nw)-1)*(length(NT)-1);
Dzord = (length(Dw)-1)*(length(DT)-1);
 
Nz = zeros(1,Nzord+1);
for k = 0:Nzord
    pln = [1];
    for l = 0:k-1
        pln = conv(pln,NT);
    end
    pld = [1];
    for l = 0:Nzord-k-1
        pld = conv(pld,DT);
    end
    Nz = Nz+Nw(k+1)*conv(pln,pld);
end
 
Dz = zeros(1,Dzord+1);
for k = 0:Dzord
    pln = [1];
    for l = 0:k-1
        pln = conv(pln,NT);
    end
    pld = [1];
    for l = 0:Dzord-k-1
        pld = conv(pld,DT);
    end
    Dz = Dz+Dw(k+1)*conv(pln,pld);
end
 
Dz1 = Dz(1); Dz = Dz/Dz1; Nz = Nz/Dz1;