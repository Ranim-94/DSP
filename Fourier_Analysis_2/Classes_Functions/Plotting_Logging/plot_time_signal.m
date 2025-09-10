

function plot_time_signal(param_plot)

% Plotting Continous Waveform, superposed with its samples


% Extracting some parameters from param_plot structure
time_scale_option_input_signal = param_plot.time_scale_option_input_signal;

time_scale = param_plot.time_scale ;


figure()

%plot time axis in ms --> multiply bu 10^3 = 1e3
plot(param_plot.time_smooth_input_signal*time_scale,...
param_plot.smooth_input_signal,'k');
hold on,
stem(param_plot.t_sampled*time_scale ,param_plot.signal_sampled);

    % Adjusting limits of x-axis according to what signal I want to plot
    % sin or cos, sinc,...
    switch param_plot.show_signal_in_time
        
        case 'show_sin'
    xlim([param_plot.start_time*time_scale  ...
        param_plot.start_time*time_scale + (4/param_plot.bandwidth_Hz)*time_scale ]);

        case 'show_sinc'    

       limit = 6*(1/(2*param_plot.bandwidth_Hz))*time_scale  ;   
        xlim([-limit   limit ]);

    end 

grid on;
set(gca,'fontsize',14,'fontweight','bold');
title('Input Signal $x(t)$','Interpreter','Latex');
xlabel(['Time in [',time_scale_option_input_signal,']'],...
            'Interpreter','Latex');
ylabel('Amplitude','Interpreter','Latex');
legend({'Continous Time','Sampled'},'Interpreter','Latex')





end % function