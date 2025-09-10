

close all, clc, clear all;

% parameters
fs_in = 192e3; % in KHz

sigRead = audioread("0C02_CarmesRuelles_20kmh.wav");

sigcomplex  = (complex(sigRead(:,1), sigRead(:,2))).';

Ts_in = (1/fs_in);

t = 0:Ts_in:(length(sigcomplex)*Ts_in)-Ts_in;

index_slice_time = find(t == 2.9) ;

t_slice = t(1:index_slice_time);

signal = sigcomplex(1:index_slice_time);

sig_spect = fftshift(fft(signal));

freq_step = fs_in/length(signal);

% -96 KHz -> 96 KHz
freq_axis = -fs_in/2:freq_step:fs_in/2 - freq_step;

plot_spectrum(sig_spect,freq_axis,'Input Spectrum');

fc_1 = 18e3*((2)/fs_in);
%fc_2 = 20e3*((2)/fs_in);

fir_order = 102;
coeff_filter = fir1(fir_order,fc_1);

nb_of_discrete_freq_point = 2048;
[freq_response_fir,discrete_freq] = freqz(coeff_filter,1,nb_of_discrete_freq_point);


filtered_signal = filter(coeff_filter,1,signal);

sig_spect_filtered = fftshift(fft(filtered_signal));

plot_spectrum(sig_spect_filtered,freq_axis,'Filtered Spectrum');

figure()
freq_axis_plot = discrete_freq.*(fs_in/(2*pi));
plot(freq_axis_plot./1e3,20*log10(abs(freq_response_fir)),'g'),
legend({'Rectangular'},'Interpreter','latex')
title(['Window Based Lowpass Filter M = ',num2str(fir_order)],...
'Interpreter','latex')
%axis([0 1 -80, 5])
grid on
xlabel('F[KHz]','Interpreter','latex')
ylabel('Gain dB','Interpreter','latex')
set(gca,'fontsize',14,'fontweight','bold');

audio_matrix = [real(filtered_signal)' imag(filtered_signal)'];

audiowrite('carme_2_9_s.wav',audio_matrix,fs_in);

%%

clear all, close all, clc;

f_sin = 10e3;

fs_in = 192e3; Ts_in = 1/fs_in;

t_end = 8; % in s

t_sin = 0:Ts_in:t_end;

test_sin_wave = sin(2*pi*f_sin*t_sin);

audiowrite('test_sin.wav',test_sin_wave,fs_in);


