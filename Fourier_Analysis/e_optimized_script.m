






close all;
clc;


% This script is to compare fft and dft for loop
% on a baseband signal
% ------------------------------------------------------------------------

%% Setting parameters

% in Hz
signal_bandwidth = 8;

f_Nyquitst = 2*signal_bandwidth;


% it will be used in the DTFT analytical form
% for comparison purpose 
optimum_sampling_rate = 2*f_Nyquitst;

sampling_factor = [1/4, 1/8];

%set signal duration (truncation) in seconds
time_duration = 16;

%variable used for indexing DTFT and CTFT plots
plot_index = 1;


%% Generating analytical expression for 

% waveform and spectrum (CTFT and DTFT)


in.optimum_sampling_rate  = optimum_sampling_rate;


in.optimum_sampling_period = 1/in.optimum_sampling_rate;

in.time_duration = time_duration;

in.signal_bandwidth = signal_bandwidth;


out = generate_analytical_sol(in);




%%
for i = 1:length(sampling_factor)

%compute the sampling rate in Hz
fs = sampling_factor(i)*f_Nyquitst;    
    
    
%set sampling time, we sample every T seconds
Ts = 1/fs;

%compute number of samples
nb_of_point = time_duration/Ts;

% for zero padding and making a dense spectrum
length_fft = 2^nextpow2(nb_of_point);

% for generating frequency bins in Hz
freq_step = fs/length_fft;


%% Setting time domain signals: analytical , sampled and discrete

%compute the time vector to sample the continuous function
t_samples = 0:Ts:Ts*(nb_of_point - 1);


a = 0.5 ;
signal_sampled  = exp(-a*t_samples);

% discrete time vector
n_vec = 0:nb_of_point-1 ;

discrete_time_signal  = exp(-a.*n_vec);

%% 
%compute the "analytical" frequency vectors
%our sampling rate is fs, so we can only see up to fs/2
    

f_analytical_hz = linspace(-signal_bandwidth,...
signal_bandwidth - freq_step,10*length_fft);

% discrete frequency in radian
%w_analytical_discrete = (f_analytical_hz.*(2*pi))./fs ;

w_analytical_discrete = (f_analytical_hz.*(2*pi))./optimum_sampling_rate ;

%compute theoretical magnitude spectrum for signals of form e^(-at)u(t)
ctft_analytical = 1./sqrt((2*pi*f_analytical_hz).^2 + a^2);

% used in DTFT analytical expression
alpha = exp(-a);

dtft_analytical = ...
1./(1 - alpha *exp(-1j*w_analytical_discrete))  ;

dtft_analytical_2 = ctft_analytical./Ts ;

%%         Applying FFT to compute CTFT and DTFT

% don't forget to multiply by Ts because from sampling theory,
% if we sample a signal in time --> the specturm get replicated
% and multiplied by scaling factor 1/Ts --> so we multiply by Ts


ctft_fft = Ts*abs(fft(signal_sampled,length_fft));

dtft_fft = abs(fft(discrete_time_signal,length_fft));

% Making the amplitude spectrum symmetrical with y axis
ctft_fft = fftshift(ctft_fft);

dtft_fft = fftshift(dtft_fft);

% Setting up frequency bins
spectral_step_fft = (2*pi)/length_fft;

% wVec = ((0:length_fft-1)*spectral_step_fft)*fs  ;

% Transfroming from radian/s --> Hz
% freq_vector_fft  = wVec/(2*pi) ;

if fs >= f_Nyquitst
    
    % Here we are doing oversampling
    % no aliasing occure
    
    freq_vector_fft =  linspace(-fs/2,fs/2 - freq_step,length_fft) ;
    
    discrete_freq_vector_fft =  freq_vector_fft.*(2*pi)./fs;
    
    show_discrete_freq = 2*pi*signal_bandwidth/fs;
    
    range1 = -2*pi*signal_bandwidth/fs;
    
    range2 = 2*pi*signal_bandwidth/fs;
    
else
    
    % In this case, we are doing downsampling
    % so aliasing will occure
    
    % adjusting the frequency bins for CTFT
    freq_vector_fft =  linspace(-signal_bandwidth,...
    signal_bandwidth - freq_step,length_fft);

    % discrete freq [-pi,pi] adjusting the frequency bins for DTFT
%     discrete_freq_vector_fft =  linspace(-pi,pi,length_fft).*...
%     (1/sampling_factor(i));

% discrete_freq_vector_fft =  linspace(-pi,pi,length_fft);

discrete_freq_vector_fft =  freq_vector_fft.*(2*pi)./signal_bandwidth;

    % Recall even if we have aliasing in this case,
    % DTFT will be always between -pi and +pi
    range1 = -pi;
    
    range2 = pi;

end

%% plot comparison of theoretical F(w) to DFT, i.e. samples of F(w



% Plot the time domain signal
figure(1),
subplot(2,2,i),
plot(out.t_analog,out.signal_analytical,'r','linewidth',2);
hold on,
stem(t_samples,signal_sampled);
grid on;
set(gca,'fontsize',14,'fontweight','bold');
xlabel('Time (s)','Interpreter','latex');
title('$f(t) = e^{(-0.5 \, t)} \, u(t)$',...
'Interpreter','latex');
ylabel('$f(t)$','Interpreter','latex');


% newline command to break the lengend into multilines
legend({['Duration = ',num2str(time_duration),' s'...
    newline '$B \, = \, $',num2str(signal_bandwidth),' Hz'...
    newline '$T_s \, = \, $',num2str(10^3*Ts)...
  ,' ms' newline '$F_s \, = \, $',num2str(fs),' Hz']},'Interpreter','latex'),


% rounding for displaying into plots

spectral_step_fft = round(spectral_step_fft,2) ;



% CTFT Plot: FFT and Closed Form
figure(2),
subplot(2,2,plot_index),
plot(freq_vector_fft,ctft_fft,'b');
xlim([-signal_bandwidth signal_bandwidth]);
hold on;
plot(f_analytical_hz,ctft_analytical,'r','linewidth',2);
grid on;
set(gca,'fontsize',14,'fontweight','bold');
xlabel('Frequency (Hz)','Interpreter','latex');
ylabel('$ | X(f_c)|$','Interpreter','latex');
title(['$ X(f_c) \, = \, \displaystyle\frac{1}{j \, 2 \pi f_c \, + \, 0.5}$', ...
      ' and $F_s = $',num2str(fs),' Hz'],'Interpreter','latex');
legend({'FFT' , 'Analytical Form'},'Interpreter','latex');

% DTFT plot: FFT and Closed Form


subplot(2,2,plot_index+1),
plot(discrete_freq_vector_fft,dtft_fft,'b');
xlim([range1 range2]);
hold on;
% plot(w_analytical_discrete,dtft_analytical_2,'r','linewidth',2);
plot(w_analytical_discrete,abs(dtft_analytical),'r','linewidth',2);
grid on;
set(gca,'fontsize',14,'fontweight','bold');
xlabel('$\omega_d$ (rad)','Interpreter','latex');
ylabel('$  |X(\omega_d)| $','Interpreter','latex');
 title(['$ X(\omega_d) \, = \, \displaystyle\frac{1}{1 - \, \alpha \, \exp(\, -j \, \omega_d \,) \, + \, 0.5}$', ...
       ' and $F_s = $',num2str(fs),' Hz'],'Interpreter','latex');

 legend({'FFT' , 'Analytical Form'},'Interpreter','latex');


plot_index = plot_index + 2;

end