

clc, close all;


% in s
time_duration = 16;

% in Hz
bandwidth = 8;

fs_analog = 1e3;

f_Nyquist = 2*bandwidth;

fs = 2*f_Nyquist;

Ts = 1/fs;

%% 

param.bandwidth = bandwidth;
        
param.time_duration = time_duration;
         
 param.fs = fs;
    
param.fs_analog = time_duration;

expo_inst = signal(param);

out_analog = expo_inst.analog();

out_sampeled = expo_inst.spectral_analysis();



%% Plotting section 

figure(1),
subplot(1,2,1),
plot(out_analog.t_analog,out_analog.signal_analog,'r','linewidth',2);
hold on,
stem(out_sampeled.t_sampeles,out_sampeled.signal_sampled);
grid on;
set(gca,'fontsize',14,'fontweight','bold');
xlabel('Time (s)','Interpreter','latex');
title('$f(t) = e^{(-0.5 \, t)} \, u(t)$',...
'Interpreter','latex');
ylabel('$f(t)$','Interpreter','latex');
% newline command to break the lengend into multilines
legend({['Duration = ',num2str(time_duration),' s'...
    newline '$B \, = \, $',num2str(bandwidth),' Hz'...
    newline '$T_s \, = \, $',num2str(10^3*Ts)...
  ,' ms' newline '$F_s \, = \, $ ',num2str(fs),' Hz']},'Interpreter','latex'),


% subplot(1,2,2),
% plot(out_analog.,out_analog.signal_analog,'r','linewidth',2);
% hold on,
% stem(out_sampeled.t_sampeles,out_sampeled.signal_sampled);
% grid on;
% set(gca,'fontsize',14,'fontweight','bold');
% xlabel('Time (s)','Interpreter','latex');
% title('$f(t) = e^{(-0.5 \, t)} \, u(t)$',...
% 'Interpreter','latex');
% ylabel('$f(t)$','Interpreter','latex');
% % newline command to break the lengend into multilines
% legend({['Duration = ',num2str(time_duration),' s'...
%     newline '$B \, = \, $',num2str(signal_bandwidth),' Hz'...
%     newline '$T_s \, = \, $',num2str(10^3*Ts)...
%   ,' ms' newline '$F_s \, = \, $ ',num2str(fs),' Hz']},'Interpreter','latex'),



