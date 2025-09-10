

function out_tx = set_up_bandpass_signal(param)


% Instantiating the object
mod_analog = Analog_Modulator(param) ;

% Generating bandpass signal  
out_tx = mod_analog.generate_rf_signal();

% Plot results 

plot_analog_modulator(out_tx,param)



% Note: for now I won't plot the continous version, I will onlu plot
% the sampled one since RF signal have high sampling rate
        
%         % Setting higher Fs to plot nice continous time
%         % domain signal superimposed with the input samples
%         % this used for plotting in time domain only 
%         %(I dont use it for computational purposes)
%         fs_analog_plot = 70*obj.f_carrier;
%         
%         % setting higher fs in the sampler object  
%         mod_analog = mod_analog.set_fs(fs_analog_plot);
%         
%         out_sampler_for_plot = mod_analog.generate_bandpass_signal();



end 