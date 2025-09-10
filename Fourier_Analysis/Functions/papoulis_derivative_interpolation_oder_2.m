



function [reconstructed_values] = ...
papoulis_derivative_interpolation_oder_2(t_analog,...
t_sampled,sampled_signal,derivative_sampled_signal,band,fs,kernel_order)

Ts = 1/fs ;

% in rad/s
bandwidth = 2*pi*band ;

new_sampling_period  = kernel_order*Ts ;

% Allocating
reconstructed_values = zeros(length(t_analog),1);

for i = 1:length(reconstructed_values)
    
    for j = 1:length(t_sampled)
    
    % Each analog value is weighted shifted sum of sinc
    % the weights are the amplitude of the discrete time signal
    
    factor = t_analog(i) - (j-1)*new_sampling_period ;
    
    arg_sin = (bandwidth*factor)./2;
    
    den_1 = bandwidth^2.*factor.^2;
    
    den_2 = bandwidth^2.*factor;
    
    reconstructed_values(i)  = reconstructed_values(i) + ...
    sampled_signal(j)* 4*(sin(arg_sin)).^2./den_1 + ...
    derivative_sampled_signal(j)* 4*(sin(arg_sin)).^2./den_2 ; 

    end
    
end


end