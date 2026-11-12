

function plot_time_signal(param)

% Plotting Continuous Waveform, superposed with its samples

%% Computing continuous time version of the signal

over_sampling = 4;

% Generating a continuous time signal axis
% to mimic this effect and also to have the same time axis (start and end)
% between continous and sampled signal, I multiply Fs and N by the same
% factor
% this way time_sampled and time_continous have same start and end 
[time_cont,sig_analog] = gen_sig(over_sampling*param.fs, ...
                            over_sampling*param.nb_samples, ...
                            param);

%% plotting part 
figure()

%plot time axis in ms --> multiply by 1e3
plot(time_cont*param.time_scale,...
     sig_analog,'k');

hold on,

% plot sampled signal
stem(param.time_axis*param.time_scale, ...
    param.sig_sampled);
%% Adjusting x-limit

    % Adjusting limits of x-axis according to what signal I want to plot
    % sin or cos, sinc,...
    switch param.choice_signal
        
        case 'sin'
    xlim([time_cont(1)*param.time_scale  ...
        time_cont(1)*param.time_scale + (4/param.bandwidth_Hz)*param.time_scale ]);

        case 'sinc'    

       limit = 6*(1/(2*param.bandwidth_Hz))*param.time_scale  ;   
        xlim([-limit   limit ]);

    end % End switch case adjusting x-axis limit

grid on;
set(gca,'fontsize',14,'fontweight','bold');
title('Input Signal $x(t)$','Interpreter','Latex');

% adjusting x-axis label
switch param.time_scale

    case 1 % in s

        time_scale_string = 's';
        

    case 1e3 % in ms

        time_scale_string = 'ms';    


end % end switch x-axis label

xlabel(['Time in [',time_scale_string,']'],...
       'Interpreter','Latex');

ylabel('Amplitude','Interpreter','Latex');
legend({'Continous Time','Sampled'},'Interpreter','Latex')





end % function