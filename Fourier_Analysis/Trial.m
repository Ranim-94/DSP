

clc, close all;

Ts = 0.0002; n = -25:1:25; nTs = n*Ts; 

t_samples = -25*Ts:Ts:25*Ts ;

f_sampled = exp(-1000*abs(t_samples));

Fs = 1/Ts;


% Analog Signal reconstruction

Dt = Ts/10; t_analytical = -0.005:Dt:0.005;

f_analytical = exp(-1000*abs(t_analytical));

f_sinc = f_sampled * sinc( Fs*( ones(length(t_samples),1)* t_analytical - t_samples' * ones(1,length(t_analytical)) ) );

comp_1 = ones(length(n),1)* t_analytical ;

% comp_1 = ;
% 
% comp_1 = ;

figure(1),
plot(t_analytical,f_analytical,'r','linewidth',2);
hold on,
stem(t_analytical,f_sinc);
grid on;
set(gca,'fontsize',14,'fontweight','bold');
xlabel('Time (s)','Interpreter','latex');
title('$f(t) = e^{(-0.5 \, t)} \, u(t)$',...
'Interpreter','latex');
ylabel('$f(t)$','Interpreter','latex');



% subplot(1,2,2),
% plot(t_analytical,f_analytical,'r','linewidth',2);
% hold on,
% stem(t_analytical,f_sinc);
% grid on;
% set(gca,'fontsize',14,'fontweight','bold');
% xlabel('Time (s)','Interpreter','latex');
% title('$f(t) = e^{(-0.5 \, t)} \, u(t)$',...
% 'Interpreter','latex');
% ylabel('$f(t)$','Interpreter','latex');

