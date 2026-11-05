




function ifft_plots(param_plot)


%---------------------- Description  ------------------------------------

% Comparison plot between smaples (resulting from sampling) and ifft output
% to see if ifft command give the samples in time

%-----------------------------------------------------------------------

% Extracting some parameters from param_plot structure
time_scale_option_input_signal = param_plot.time_scale_option_input_signal;

time_scale = param_plot.time_scale ;

   
        
figure()
subplot(1,2,1)


switch time_scale_option_input_signal
    
    
    case {'ms','micros'}

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
title('Samples plot of $x(t)$','Interpreter','Latex');
xlabel(['Time in [',time_scale_option_input_signal,']'],...
            'Interpreter','Latex');
ylabel('Amplitude','Interpreter','Latex');



    case 's'
     
plot(param_plot.time_smooth_input_signal,...
param_plot.smooth_input_signal,'k');
hold on,
stem(param_plot.t_sampled*time_scale ,param_plot.signal_sampled);
grid on;
set(gca,'fontsize',14,'fontweight','bold');
title('Samples plot of $x(t)$','Interpreter','Latex');
xlabel('Time [s]','Interpreter','Latex');
ylabel('Amplitude','Interpreter','Latex');
        
        
end 

%********************** Samples using IFFT *********************


subplot(1,2,2)

switch time_scale_option_input_signal
    
    
    case {'ms','micros'}


%plot time axis in ms --> multiply bu 10^3 = 1e3
plot(param_plot.time_smooth_input_signal*time_scale,...
param_plot.smooth_input_signal,'k');
hold on,
% here I use the ifft time domain samples
stem(param_plot.t_sampled*time_scale ,param_plot.signal_ifft);

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
title('IFFT Plot $x(t)$','Interpreter','Latex');
xlabel(['Time in [',time_scale_option_input_signal,']'],...
            'Interpreter','Latex');
ylabel('Amplitude','Interpreter','Latex');



    case 's'
     
plot(param_plot.time_smooth_input_signal,...
param_plot.smooth_input_signal,'k');
hold on,
% Here I use the ifft samples 
stem(param_plot.t_sampled ,param_plot.signal_ifft);
grid on;
set(gca,'fontsize',14,'fontweight','bold');
title('Input Signal $x(t)$','Interpreter','Latex');
xlabel('Time [s]','Interpreter','Latex');
ylabel('Amplitude','Interpreter','Latex');
        
        
end 



    

   
    





end % function