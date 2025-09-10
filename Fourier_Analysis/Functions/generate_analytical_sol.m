


function out = generate_analytical_sol(in)


% Time domain signal: generating analog signal

% key idea: analog signal will be simulated
% as having a step much more smaller then (1/optimum_sampling_freq)


%compute number of samples
nb_of_point_analog = in.time_duration/in.optimum_sampling_period;

% for zero padding and making a dense spectrum
length_fft = 2^nextpow2(nb_of_point_analog);

% for generating frequency bins in Hz
freq_step = in.optimum_sampling_rate/length_fft;

% computing t analytical for compairson
out.t_analog = ...
0:(in.optimum_sampling_period/5):in.optimum_sampling_period*(nb_of_point_analog - 1);

a  = 0.5;
out.signal_analytical  = exp(-a*out.t_analog);

%************* Analytical CTFT and DTFT *********************


out.f_analytical_hz = linspace(-in.signal_bandwidth,...
in.signal_bandwidth - freq_step,10*length_fft);

% discrete frequency in radian
%w_analytical_discrete = (f_analytical_hz.*(2*pi))./fs ;

% out.w_analytical_discrete = (out.f_analytical_hz.*(2*pi))./in.optimum_sampling_rate ;

out.w_analytical_discrete = (out.f_analytical_hz.*(2*pi))./in.signal_bandwidth ;

%compute theoretical magnitude spectrum for signals of form e^(-at)u(t)
out.ctft_analytical = 1./sqrt((2*pi*out.f_analytical_hz).^2 + a^2);

% used in DTFT analytical expression
alpha = exp(-a);

out.dtft_analytical = ...
1./(1 - alpha *exp(-1j*out.w_analytical_discrete))  ;



end