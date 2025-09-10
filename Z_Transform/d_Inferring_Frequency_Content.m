


%% First order low pass system

clc, close all;

coeff_num = [1];

coeff_deno = [1 , -1/3];

% drawing the zero-pole diagram in the z-plane

nb_of_discrete_freq_point = 100;

[discrete_freq_response,discrete_freq] = ...
freqz(coeff_num,coeff_deno,nb_of_discrete_freq_point);

% normalized phase reponse

normalize_phase = angle_chosen(discrete_freq_response)./pi;

figure(1),
subplot(2,1,1),
plot(discrete_freq/pi,abs(discrete_freq_response),...
'linewidth',2);
xlabel('Normalized Frequency','Interpreter','latex');
title('Amplitude Response','Interpreter','latex');
set(gca,'fontsize',14,'fontweight','bold');
grid on;

subplot(2,1,2),
plot(discrete_freq/pi,normalize_phase,...
'linewidth',2);
grid on;
set(gca,'fontsize',14,'fontweight','bold');
title('Normalized Phase Response','Interpreter','latex');
xlabel('Normalized Frequency $\frac{\omega_d}{\pi}$',...
'Interpreter','latex');

figure(2),
zplane(coeff_num,coeff_deno),
set(gca,'fontsize',14,'fontweight','bold');


%% Second order low pass system

clc, close all;

radius = 5/6;
angle_chosen = pi/3;

% used in freqz
nb_of_discrete_freq_point = 100;

coeff_num = [0, radius*sin(angle_chosen)];

coeff_deno = [1, -2*radius*cos(angle_chosen),radius^2];

% drawing the zero-pole diagram in the z-plane



[discrete_freq_response,discrete_freq] = ...
freqz(coeff_num,coeff_deno,nb_of_discrete_freq_point);

% normalized phase reponse

normalize_phase = angle(discrete_freq_response)./pi;

figure(1),
subplot(2,1,1),
plot(discrete_freq/pi,abs(discrete_freq_response),...
'linewidth',2);
xlabel('Normalized Frequency','Interpreter','latex');
title('Amplitude Response','Interpreter','latex');
set(gca,'fontsize',14,'fontweight','bold');
grid on;

subplot(2,1,2),
plot(discrete_freq/pi,normalize_phase,...
'linewidth',2);
grid on;
set(gca,'fontsize',14,'fontweight','bold');
title('Normalized Phase Response','Interpreter','latex');
xlabel('Normalized Frequency $\frac{\omega_d}{\pi}$',...
'Interpreter','latex');

figure(2),
zplane(coeff_num,coeff_deno),
set(gca,'fontsize',14,'fontweight','bold');






%%

% See the book for other case of use for freqz
