

function fft_analytical_plot(param_plot)


% Plotting CTFT Amplitude and Phase spectrum

% Ampitude of CTFT using FFT

figure()
plot(param_plot.freq_vect_fft_Hz,abs(param_plot.fft_comp)./param_plot.fs);
hold on,

% Testing which input signal we have,
% to implement closed form expression of Fourier transform
if strcmp(param_plot.choice_signal,'sinc_square')
    
    % B*Sinc^2(pi B t) = triang(F/2B);
    analytical_CTFT = tripuls(param_plot.freq_vect_fft_Hz,...
    2*param_plot.bandwidth_Hz) ;

elseif strcmp(param_plot.choice_signal,'sinc')
    
    % 2*B*Sinc(2pi B t) = rect(F/2B);
    analytical_CTFT = rectpuls(param_plot.freq_vect_fft_Hz,...
    2*param_plot.bandwidth_Hz) ;
    
elseif strcmp(param_plot.choice_signal,'sin')
    
    % 2*B*Sinc(2pi B t) = rect(F/2B);
   
% Extracing some parameters to make writing the formula easier

tau = param_plot.end_time - param_plot.start_time; % window width in s

A = param_plot.signal_amp ;

F  = param_plot.freq_vect_fft_Hz;

f0  = param_plot.bandwidth_Hz;

analytical_CTFT = ((A*tau)/2)*( sinc((F- f0)*tau) + sinc((F+f0)*tau) ) ;


end  % End testing which input signal we have

% Plot analytical Fourier transform
plot(param_plot.freq_vect_fft_Hz,abs(analytical_CTFT));


xlim([-param_plot.show_freq_input param_plot.show_freq_input]);
grid on;
set(gca,'fontsize',14,'fontweight','bold');
title('FFT Comparison with Closed Form Expression','Interpreter','Latex');
xlabel('Frequency [Hz]','Interpreter','Latex');
ylabel('Amplitude','Interpreter','Latex');
legend({'FFT','Analytical Formula'},'Interpreter','Latex')

end 