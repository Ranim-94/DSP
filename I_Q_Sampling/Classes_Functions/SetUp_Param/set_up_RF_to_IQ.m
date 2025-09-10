

function out_rf_to_iq = set_up_RF_to_IQ(out_tx,param)

param_iq.rf_signal = out_tx.rf_signal ;

param_iq.f_conversion = param.f_conversion;

% time axis of the RF signal
param_iq.t_sampled  = out_tx.t_sampled; 

% Instantiation

iq_obj = RF_to_IQ(param_iq);

%  run

out_rf_to_iq = iq_obj.generate();

% plotting result
plot_iq(out_rf_to_iq,out_tx,param);



end % End function 