

function plot_iq(out_rf_to_iq,out_tx,param)

% Input: i(t),q(t),
% eq low pass spectrum where x_eq(t) = i(t)+ j q(t)
% Real message spectrum
% freq axis


% Plot I and Q component for complex low pass equivalent signal

figure()




subplot(2,1,1)


% I(t)
plot(out_tx.t_sampled*param.time_scale,out_rf_to_iq.i);
hold on;
% Q(t)
plot(out_tx.t_sampled*param.time_scale ,out_rf_to_iq.q);

    % Adjusting limits of x-axis according to what signal I want to plot
    % sin or cos, sinc,...
    switch param.show_signal_in_time
        
        case 'show_sin'
    xlim([param.start_time*param.time_scale  ...
        param.start_time*param.time_scale + (4/param.bandwidth_Hz)*param.time_scale]);

        case 'show_sinc'    

       limit = 6*(1/(2*param.bandwidth_Hz))*param.time_scale  ;   
        xlim([-limit   limit ]);

    end 

grid on;
set(gca,'fontsize',14,'fontweight','bold');
title('I-Q Waveform','Interpreter','Latex');

% Set time unit for printing
time_scale_string = set_time_unit(param.time_scale);
xlabel(['Time [',time_scale_string,']'],'Interpreter','Latex');
        
ylabel('Amplitude','Interpreter','Latex');
legend({'I-Ch','Q-Ch'},'Interpreter','Latex');

   
% ====================== Spectrum of complex enveloppe =============

subplot(2,1,2)

% real baseband message
plot(out_tx.freq_axis_Hz./param.scale_freq,abs(out_tx.spectr_msg));
hold on
% complex envelope x_l(t) = x_i(t)+ j*x_q(t)
plot(out_tx.freq_axis_Hz./param.scale_freq,abs(out_rf_to_iq.comp_evelope_spectr));

% setting limit for freq axis
limit_freq_axis = (2*param.bandwidth_Hz)/param.scale_freq ;
xlim([-limit_freq_axis  limit_freq_axis]);

grid on;
set(gca,'fontsize',14,'fontweight','bold');
title('Amplitude Spectrum','Interpreter','Latex');

% setting Freq axis unit 
unit_freq = set_freq_unit(param.scale_freq);
xlabel(['F [' unit_freq ']'],'Interpreter','Latex');

legend({'Real Message','Complex Envelope'},'Interpreter','Latex');


end % End function 