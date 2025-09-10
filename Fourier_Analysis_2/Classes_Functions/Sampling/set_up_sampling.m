

function [out_sampler,out_sampler_for_plot] = set_up_sampling(param_local)


        % Instantiating the object
        sampler = Sampler(param_local) ;

        % Sampling and generating signal  
        out_sampler = sampler.sampling_uniform();


        % Setting higher Fs to plot nice continous time
        % domain signal superimposed with the input samples
        % this used for plotting in time domain only 
        %(I dont use it for computational purposes)
        fs_analog_plot = 70*param_local.bandwidth_Hz;
        
        % setting higher fs in the sampler object  
        sampler = sampler.set_fs(fs_analog_plot);
        
        out_sampler_for_plot = sampler.sampling_uniform();



end 