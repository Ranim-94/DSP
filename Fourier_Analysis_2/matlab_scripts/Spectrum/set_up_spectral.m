

function out_spectral = set_up_spectral(out_sampler,param_local)

% Set up parameter to do spectral analysis (fft)

        % Specifying the parameters

 param_spectral.signal_sampled  = out_sampler.signal_sampled ;

param_spectral.nb_of_samples  = out_sampler.nb_of_samples ;

param_spectral.fs = param_local.fs ;

param_spectral.bandwidth_Hz = param_local.bandwidth_Hz;

param_spectral.zero_padd = param_local.zero_padd ;

param_spectral.show_debug = param_local.show_debug ;


        % instantiating
 spectral = Spectral(param_spectral) ;

out_spectral = spectral.compute_fft();





end