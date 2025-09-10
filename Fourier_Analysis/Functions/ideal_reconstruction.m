



function [reconstructed_values] = ideal_reconstruction(t_analog,...
t_sampled,sampled_signal,fs)

Ts = 1/fs ;

% Allocating
reconstructed_values = zeros(length(t_analog),1);

for i = 1:length(reconstructed_values)
    
    for j = 1:length(t_sampled)
    
    % Each analog value is weighted shifted sum of sinc
    % the weights are the amplitude of the discrete time signal
    
    reconstructed_values(i)  = reconstructed_values(i) + ...
    sampled_signal(j)* sinc(fs*(t_analog(i) - (j-1)*Ts )); 

    end
    
end


end