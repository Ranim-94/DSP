




function fft_plots_multiple_fs(param_plot)


%********************** Spectrum *********************



figure()

% Ampitude of CTFT using FFT: over 1 period only the normal one
subplot(2,1,1)
plot(param_plot.freq_vector_input,...
param_plot.ctft_amp);
grid on;
set(gca,'fontsize',14,'fontweight','bold');
title('CTFT $x(t)$: from $\frac{-F_s}{2} \rightarrow \frac{F_s}{2}$',...
'Interpreter','Latex');
xlabel('Frequency (Hz)','Interpreter','Latex');
ylabel('Amplitude','Interpreter','Latex');
% Setting limits
xlim([-param_plot.fs/2 param_plot.fs/2]);
xticks([-param_plot.fs/2 param_plot.fs/2])
xticklabels({'{-F_s/2}','{F_s/2}'})




% Ampitude of CTFT using FFT: 
% from -3Fs/2 --> 3Fs/2

subplot(2,1,2)
plot(param_plot.freq_axis_multiple_fs,...
abs(param_plot.ctft_comp_multiple_fs));
grid on;
set(gca,'fontsize',14,'fontweight','bold');
title('CTFT $x(t)$: from $\frac{-3F_s}{2} \rightarrow \frac{3F_s}{2}$',...
'Interpreter','Latex');
xlabel('Frequency (Hz)','Interpreter','Latex');
ylabel('Amplitude','Interpreter','Latex');
% Setting limits
xlim([-3*param_plot.fs/2 3*param_plot.fs/2]);
xticks([-3*param_plot.fs/2 -param_plot.fs  -param_plot.fs/2 ... 
    param_plot.fs/2 param_plot.fs 3*param_plot.fs/2])
xticklabels([{'-3Fs/2','Fs','-Fs/2','Fs/2','Fs','3Fs/2'},'Interpreter','Latex'])


    

   
    





end % function