


function [delayed_signal] = perform_delay(input_signal,delay,fs_input_signal)

slen = length(input_signal);

fs = fs_input_signal;

% To use max. computational efficiency of FFT
length_fft = 2^nextpow2(2*slen); 
%  Create frequency shift vectors(bins)

freq_step = fs/length_fft ;

freq_bins = -fs/2:freq_step:fs/2 - freq_step; 

% w=2*pi*fax,, Frequency function for delay
      shft = exp(-1i*delay*2*pi*freq_bins);   
      
      % Make axis compatable with numeric FFT
      % that is the freq bins come from 0 --> Fs
      shft = ifftshift(shft);         
      
      % Take FFT
      ctft_input = fft(input_signal,length_fft);
      
      %  Apply delay
      ctft_delayed = ctft_input.*shft;                
      
      %  Return to time domain
      dum = ifft(ctft_delayed);
      
      %  time domain signal to required length
      delayed_signal = real(dum(1:slen));    


end 