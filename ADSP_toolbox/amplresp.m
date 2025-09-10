function [Hr,w,P,L] = ampl_res(h,w)
%
% function [Hr,w,P,L] = ampl_res(h)
%
% Computes Amplitude response Hr(w) and its polynomial P of order L,
%   given a linear-phase FIR filter impulse response h.
% The type of filter is determined automatically by the subroutine.
%
% Hr = Amplitude Response
%  w = frequencies between [0 pi] over which Hr is computed
%  P = Polynomial coefficients
%  L = Order of P
%  h = Linear Phase filter impulse response
%

 M = length(h);
 L = floor(M/2);
if fix(abs(h(1:1:L))*10^10) ~= fix(abs(h(M:-1:M-L+1))*10^10)
	error('Not a linear-phase impulse response')
end
if nargin == 1
    w = [0:1:500]'*pi/500;
else
    w = w(:);
end

if 2*L ~= M
	if fix(h(1:1:L)*10^10) == fix(h(M:-1:M-L+1)*10^10)
		disp('*** Type-1 Linear-Phase Filter ***')
		[Hr,w,P,L] = hr_type1(h,w);
	elseif fix(h(1:1:L)*10^10) == -fix(h(M:-1:M-L+1)*10^10)
		disp('*** Type-3 Linear-Phase Filter ***')
		h(L+1) = 0;
		[Hr,w,P,L] = hr_type3(h,w);
	end
else
	if fix(h(1:1:L)*10^10) == fix(h(M:-1:M-L+1)*10^10)
		disp('*** Type-2 Linear-Phase Filter ***')
		[Hr,w,P,L] = hr_type2(h,w);
	elseif fix(h(1:1:L)*10^10) == -fix(h(M:-1:M-L+1)*10^10)
		disp('*** Type-4 Linear-Phase Filter ***')
		[Hr,w,P,L] = hr_type4(h,w);
	end
end

%% Subfunctions:
function [Hr,w,a,L] = hr_type1(h,w)
% Computes Amplitude response Hr(w) of a Type-1 LP FIR filter
% -----------------------------------------------------------
% [Hr,w,a,L] = Hr_Type1(h)
% Hr = Amplitude Response
%  w = 500 frequencies between [0 pi] over which Hr is computed
%  a = Type-1 LP filter coefficients
%  L = Order of Hr
%  h = Type-1 LP filter impulse response
%
 M = length(h);
 L = (M-1)/2;
 a = [h(L+1) 2*h(L:-1:1)]; % 1x(L+1) row vector
 n = [0:1:L];              % (L+1)x1 column vector
%  w = [0:1:500]'*pi/500;
if nargin == 1
    w = [0:1:500]'*pi/500;
else
    w = w(:);
end
Hr = cos(w*n)*a';

function [Hr,w,b,L] = hr_type2(h,w)
% Computes Amplitude response of Type-2 LP FIR filter
% ---------------------------------------------------
% [Hr,w,b,L] = Hr_Type2(h)
% Hr = Amplitude Response
%  w = frequencies between [0 pi] over which Hr is computed
%  b = Type-2 LP filter coefficients
%  L = Order of Hr
%  h = Type-2 LP impulse response
% 
 M = length(h);
 L = M/2;
 b = 2*[h(L:-1:1)];
 n = [1:1:L]; n = n-0.5;
%  w = [0:1:500]'*pi/500;
if nargin == 1
    w = [0:1:500]'*pi/500;
else
    w = w(:);
end
Hr = cos(w*n)*b';

function [Hr,w,c,L] = hr_type3(h,w)
% Computes Amplitude response Hr(w) of a Type-3 LP FIR filter
% -----------------------------------------------------------
% [Hr,w,c,L] = Hr_Type3(h)
% Hr = Amplitude Response
%  w = frequencies between [0 pi] over which Hr is computed
%  c = Type-3 LP filter coefficients
%  L = Order of Hr
%  h = Type-3 LP impulse response
%
 M = length(h);
 L = (M-1)/2;
 c = [2*h(L+1:-1:1)];
 n = [0:1:L];
%  w = [0:1:500]'*pi/500;
if nargin == 1
    w = [0:1:500]'*pi/500;
else
    w = w(:);
end
Hr = sin(w*n)*c';

function [Hr,w,d,L] = hr_type4(h,w)
% Computes Amplitude response of Type-4 LP FIR filter
% ---------------------------------------------------
% [Hr,w,d,L] = Hr_Type4(h)
% Hr = Amplitude Response
%  w = frequencies between [0 pi] over which Hr is computed
%  d = Type-4 LP filter coefficients
%  L = Order of d
%  h = Type-4 LP impulse response
% 
 M = length(h);
 L = M/2;
 d = 2*[h(L:-1:1)];
 n = [1:1:L]; n = n-0.5;
%  w = [0:1:500]'*pi/500;
if nargin == 1
    w = [0:1:500]'*pi/500;
else
    w = w(:);
end
Hr = sin(w*n)*d';


