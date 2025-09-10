
function [spectral_step,wVec,freq_vector,dft_values] = ...
dft_dtft(nb_of_points_signal,sampled_signal)

%initialize the DFT vector
dft_values = zeros(nb_of_points_signal,1);


%compute Spectral Step Omega0
spectral_step = 2*pi/nb_of_points_signal;

%compute the DFT, i.e. the Fr
for r = 0:nb_of_points_signal - 1
    
    dft_values(r+1) = 0;
    
    for k = 0:nb_of_points_signal - 1
        
        dft_values(r+1) = dft_values(r+1) + ...
        sampled_signal(k+1)*exp(-j*r*spectral_step*k);
    
    end
    
    
end

% generating frequency bins in Hz
% freq_vector = (((0:nb_of_point-1)*spectral_step * fs )./(2*pi) )' ;

wVec = (0:nb_of_points_signal-1)*spectral_step  ;

freq_vector  = wVec/(2*pi) ;

end