
function [freq_vector,dft_values,spectral_step] = dft_ctft(nb_of_point,...
                                sampled_signal,fs)

%initialize the DFT vector
dft_values = zeros(nb_of_point,1);


Ts = 1/fs ;

spectral_step = (2*pi)/nb_of_point ;

%compute the DFT, i.e. the Fr
for r = 0:nb_of_point - 1
    
    dft_values(r+1) = 0;
    
    for k = 0:nb_of_point - 1
        
        dft_values(r+1) = dft_values(r+1) + ...
        Ts * sampled_signal(k+1)*exp(-j*r*spectral_step*k);
    
    end
    
    
end

% generating frequency bins in Hz
% freq_vector = (((0:nb_of_point-1)*spectral_step * fs )./(2*pi) )' ;

wVec = [(0:nb_of_point-1)*spectral_step]*fs  ;

freq_vector  = wVec/(2*pi) ;

end