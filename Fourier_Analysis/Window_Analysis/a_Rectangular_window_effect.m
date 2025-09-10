


%% DTFT of rectangular window
%
% Compare magnitudes of of DTFT of window for different lengths, N = 25 and
% N = 50.  Note that mainlobe is narrower for N=50, but ratio of mainlobe
% height to sidelobe height is unchanged.

clc;

Om = [-1000:1000]*pi/1000; % values in frequency to eval W(Om)

N = 25;

% ./ does element by element divide
W1 = exp(j*Om*(N-1)/2).*sin(Om*N/2)./sin(Om/2);  

N = 50;
W2 = exp(j*Om*(N-1)/2).*sin(Om*N/2)./sin(Om/2);  

figure(1), 
subplot(2,2,1)
plot(Om,abs(W1));grid on
title('N = 25, linear scale','Interpreter','latex')
xlabel('Freq (rads)','Interpreter','latex')
axis([-pi,pi,0,max(abs(W1))])

subplot(2,2,3)
h=plot(Om,abs(W2));
title('N = 50, linear scale','Interpreter','latex')
xlabel('Freq (rads)','Interpreter','latex'),grid on
axis([-pi,pi,0,max(abs(W2))])

subplot(2,2,2)
plot(Om,20*log10(abs(W1)));
title('N = 25, dB scale','Interpreter','latex')
xlabel('Freq (rads)','Interpreter','latex'),grid on
ylabel('dB','Interpreter','latex')
axis([-pi,pi,-30,max(20*log10(abs(W1)))])

subplot(2,2,4)
plot(Om,20*log10(abs(W2)));
title('N = 50, dB scale','Interpreter','latex')
xlabel('Freq (rads)','Interpreter','latex')
ylabel('dB','Interpreter','latex'),grid on
axis([-pi,pi,-30,max(20*log10(abs(W2)))])