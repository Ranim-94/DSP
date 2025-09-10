

clc,close all; 

%set time vector and frequency for "continous-time" sinusoid
tMax = 5;

% 1 ms
step_size = 10^-3 ;

time = 0:10^-3:tMax;

% in Hz
f_signal  = 10;
amplitude_signal = 1 ;

%create analytical continous time signal
continous_time_signal = cos(2*pi*f_signal*time);

% -10 Hz --> 10 Hz 
f_analytical_hz = linspace(-2*f_signal,2*f_signal,1000);

window_length = max(time)/2 ;

nb_1 = (2*pi*(f_analytical_hz - f_signal )*window_length)/pi ;

nb_2 = (2*pi*(f_analytical_hz + f_signal )*window_length)/pi ;

spectrum_analytical = (amplitude_signal/2)*(sinc(nb_1) + sinc(nb_2)) ; 



figure(1)
subplot(1,2,1),
% Time domain
plot(time,continous_time_signal);
title(['$x(t) \, =  cos \left( \, 2 \pi f \, t \, \right) ; f = $ ',...
    num2str(f_signal),' Hz'],'Interpreter','latex'),grid on,
xlabel('$t$ (s)','Interpreter','latex')
ylabel('Amplitude','Interpreter','latex')
set(gca,'fontsize',14,'fontweight','bold');


subplot(1,2,2)
plot(f_analytical_hz,abs(spectrum_analytical));
title('$X(\omega_c) \, = \, \displaystyle\frac{A}{2} \, sinc(f + f_o) + \displaystyle\frac{A}{2} \, sinc(f - f_o)$',...
'Interpreter','latex'),grid on,
xlabel('$f_c$ (Hz)','Interpreter','latex')
ylabel('Amplitude','Interpreter','latex')
set(gca,'fontsize',14,'fontweight','bold');

%% Computing FFT 


clc, close all ;

%set sampling rate for sampled sinusoid
f_sampling = 7;

sampling_period = 1/f_sampling ;

t_Samp = 0:sampling_period:tMax;


% Sampeled Signal 

xSamp = cos(2*pi*f_signal*t_Samp);

zero_padding = 4*4^nextpow2(length(xSamp));

spectrum_fft = abs(fft(xSamp,zero_padding))/(2*length(xSamp));

spectral_step = (2*pi)/zero_padding;

wVec = [(0:zero_padding-1)*spectral_step]*f_sampling  ;

frequency_bins_hz  = wVec/(2*pi) ;

% frequency_bins_hz = linspace(-f_sampling/2,f_sampling/2,zero_padding);

[f_Alias,m] = compute_alias(f_sampling,f_signal) ;

% this is the new signal
xnew = cos(2*pi*f_Alias*time);


%compute aliased frequency
if f_sampling <= 2*f_signal
    
    figure(2),subplot(1,2,1),
    %plot aliased sinusoid
    plot(time,continous_time_signal);
    hold on,
    plot(time,xnew,'r','linewidth',2);
    title('$x(t) \, =  cos \left( \, 2 \pi f \, t \, \right)$',...
    'Interpreter','latex')
    
    legend({['f = $ ',num2str(f_signal),' Hz ; ','$ Alias freq = ',...
        num2str(f_Alias)]},...
    'Interpreter','latex'),grid on,
    xlabel('$t$ (s)','Interpreter','latex')
    ylabel('Amplitude','Interpreter','latex'),
    set(gca,'fontsize',14,'fontweight','bold');
    
    
    
    subplot(1,2,2)
plot(f_analytical_hz,abs(spectrum_analytical));
hold on;
plot(frequency_bins_hz,spectrum_fft);
title('$X(\omega_c) \, = \, \displaystyle\frac{A}{2} \, sinc(f + f_o) + \displaystyle\frac{A}{2} \, sinc(f - f_o)$',...
'Interpreter','latex'),grid on,
legend({'Analytical Form','Numerical using FFT'},'Interpreter','latex')
xlabel('$f_c$ (Hz)','Interpreter','latex')
ylabel('Amplitude','Interpreter','latex')
set(gca,'fontsize',14,'fontweight','bold');
    
    
else
    
  figure(2),subplot(1,2,1),
    %plot aliased sinusoid
    plot(time,continous_time_signal);
    hold on,
    plot(time,xnew,'r','linewidth',2);
    title('$x(t) \, =  cos \left( \, 2 \pi f \, t \, \right)$',...
    'Interpreter','latex')
    
    legend({'f = $ ',num2str(f_signal),' Hz ; ','$ Alias freq = ',...
        num2str(f_Alias)},...
    'Interpreter','latex'),grid on,
    xlabel('$t$ (s)','Interpreter','latex')
    ylabel('Amplitude','Interpreter','latex'),
    set(gca,'fontsize',14,'fontweight','bold');
    
    
    
    subplot(1,2,2)
plot(f_analytical_hz,abs(spectrum_analytical));
hold on;
plot(frequency_bins_hz,spectrum_fft);
title('$X(\omega_c) \, = \, \displaystyle\frac{A}{2} \, sinc(f + f_o) + \displaystyle\frac{A}{2} \, sinc(f - f_o)$',...
'Interpreter','latex'),grid on,
xlabel('$f_c$ (Hz)','Interpreter','latex')
ylabel('Amplitude','Interpreter','latex')
set(gca,'fontsize',14,'fontweight','bold');
    
    
end
