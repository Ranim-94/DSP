

function out_numerical = gnenerate_numerical_signals(in)


%set sampling time, we sample every T seconds
Ts = 1/in.fs;

%compute number of samples
nb_of_point = in.time_duration/Ts;

% for zero padding and making a dense spectrum
length_fft = 2^nextpow2(nb_of_point);

% for generating frequency bins in Hz
freq_step = in.fs/length_fft;

%% Setting time domain signals: analytical , sampled and discrete

%compute the time vector to sample the continuous function
out_numerical.t_samples = 0:Ts:Ts*(nb_of_point - 1);

%we work with the continuous signal f(t) = e(-at)u(t) in this example

a = 0.5;

out_numerical.signal_sampled  = exp(-a.*out_numerical.t_samples);

% discrete time vector
out_numerical.n_vec = 0:nb_of_point-1 ;

out_numerical.discrete_time_signal  = exp(-a.*out_numerical.n_vec);

% Computing derivative analytically for Papoullis
out_numerical.signal_analytical_derivative  = -a * exp(-a*out_numerical.t_samples);

%%         Applying FFT to compute CTFT and DTFT

% don't forget to multiply by Ts because from sampling theory,
% if we sample a signal in time --> the specturm get replicated
% and multiplied by scaling factor 1/Ts --> so we multiply by Ts


ctft_fft = Ts*abs(fft(out_numerical.signal_sampled,length_fft));

dtft_fft = abs(fft(out_numerical.discrete_time_signal,length_fft));

% Making the amplitude spectrum symmetrical with y axis
out_numerical.ctft_fft = fftshift(ctft_fft);

out_numerical.dtft_fft = fftshift(dtft_fft);

% Setting up frequency bins

if in.fs >= in.f_Nyquitst
    
    % Here we are doing oversampling
    % no aliasing occure
    
    out_numerical.freq_vector_fft =  linspace(-in.fs/2,in.fs/2 - freq_step,length_fft) ;
    
    out_numerical.discrete_freq_vector_fft =  out_numerical.freq_vector_fft.*(2*pi)./in.fs;
        
    out_numerical.range1 = -2*pi*in.signal_bandwidth/in.fs;
    
    out_numerical.range2 = -out_numerical.range1 ;
    
else
    
    % In this case, we are doing downsampling
    % so aliasing will occure
    
    % adjusting the frequency bins for CTFT
    out_numerical.freq_vector_fft =  linspace(-in.signal_bandwidth,...
    in.signal_bandwidth - freq_step,length_fft);

    % discrete freq [-pi,pi] adjusting the frequency bins for DTFT
    
out_numerical.discrete_freq_vector_fft =  out_numerical.freq_vector_fft.*(2*pi)./in.fs;

    % Recall even if we have aliasing in this case,
    % DTFT will be always between -pi and +pi
    out_numerical.range1 = -pi;
    
    out_numerical.range2 = pi;

end


end