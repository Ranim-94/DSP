

function plot_analog_modulator(out_tx,param)

% Plot Message + Modulated Signal (in time and frequecy)

% Message and modulated signal are superimposed

figure()

subplot(2,1,1)

%plot time axis in ms --> multiply bu 10^3 = 1e3

% Baseband Message
plot(out_tx.t_sampled*param.time_scale,out_tx.message_signal);
hold on;
% RF signal
plot(out_tx.t_sampled*param.time_scale,out_tx.rf_signal);

    % Adjusting limits of x-axis according to what signal I want to plot
    % sin or cos, sinc,...
    switch param.show_signal_in_time
        
        case 'show_sin'
    xlim([param.start_time*param.time_scale  ...
        param.start_time*param.time_scale + ...
        (4/param.bandwidth_Hz)*param.time_scale ]);

        case 'show_sinc'    

       limit = 6*(1/(2*param.bandwidth_Hz))*param.time_scale;
       
       xlim([-limit   limit ]);

    end 

grid on;
set(gca,'fontsize',14,'fontweight','bold');
title('Waveform','Interpreter','Latex');

% Set time unit for printing
time_scale_string = set_time_unit(param.time_scale);
xlabel(['Time [',time_scale_string,']'],...
            'Interpreter','Latex');
ylabel('Amplitude','Interpreter','Latex');


legend_analog_modulation = set_up_legend(param.modulation_type);

legend({'Message',legend_analog_modulation},'Interpreter','Latex');


% ============== Sepctrum  =======================

% spectrum plot
subplot(2,1,2)

% Message Spectrum 
plot(out_tx.freq_axis_Hz./param.scale_freq,abs(out_tx.spectr_msg));

hold on

% RF spectrum 
plot(out_tx.freq_axis_Hz./param.scale_freq,abs(out_tx.spectr_rf));


% setting limit for freq axis

limit_freq_axis = (param.f_carrier + 2*param.bandwidth_Hz)/param.scale_freq ;
xlim([-limit_freq_axis  limit_freq_axis]);

grid on;
set(gca,'fontsize',14,'fontweight','bold');

title('Spectrum','Interpreter','Latex');
ylabel('Amplitude','Interpreter','latex')

unit_freq = set_freq_unit(param.scale_freq);

xlabel(['F [' unit_freq ']'],'Interpreter','Latex');

legend({'Message',legend_analog_modulation},'Interpreter','Latex');




end % End function 