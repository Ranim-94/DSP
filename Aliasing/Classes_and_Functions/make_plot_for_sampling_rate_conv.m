

function make_plot_for_sampling_rate_conv(param_plot)


% Extracting some parameter from param_plot structure
% just to make the name variables shorter when programming

time_scale_option_input_signal = param_plot.time_scale_option_input_signal;

% multiplicative factor for the time axis
time_scale = param_plot.time_scale ;

nb_samples_for_each_fs = param_plot.nb_samples_for_each_fs;

show_sinc_interpol = param_plot.show_sinc_interpol;

dtft_plot = param_plot.dtft_plot;

switch param_plot.what_to_plot

    case 'dowsample_plot'
   
        
figure()

for index_plot = 1:length(param_plot.target_Fs) 

range_samples = nb_samples_for_each_fs(index_plot);    
    
subplot(1,2,index_plot)    
    
switch time_scale_option_input_signal
    
    
    case {'ms','micros'}

        %plot time axis in ms --> multiply bu 10^3 = 1e3
        plot(param_plot.t_input*time_scale ,param_plot.input_signal);
        hold on
        
           if strcmp(show_sinc_interpol,'True')
           % Here I want to plot sinc interpolation    
               
           plot(param_plot.t_input*time_scale,...
           param_plot.reconstructed_signals(index_plot,:));
           legend({'Original','Sinc Interpolation'},'Interpreter','latex')
           title(['Reconstruction of $x(t)$ at $F_s = $ ',...
               num2str(param_plot.target_Fs(index_plot)),' Hz'],...
           'Interpreter','Latex');
           
           else    

            % Plot downsampled samples
            stem(param_plot.new_timeaxis(index_plot,1:range_samples)*time_scale,...
            param_plot.down_signals(index_plot,1:range_samples));
            legend({['Samples at ','Fs = ',...
            num2str(param_plot.target_Fs(index_plot)),' Hz']},...
            'Interpreter','latex')
        title('Input Signal $x(t)$','Interpreter','Latex');
        
            end 
        
        % Adjusting limits of x-axis according to what signal I want to plot
        % sin or cos, sinc,...
        switch param_plot.show_signal_in_time
        
        case 'show_sin'
        xlim([param_plot.start_time*time_scale  ...
        param_plot.start_time*time_scale + param_plot.show_time]);

        case 'show_sinc'    

       limit = 6*(1/(2*param_plot.bandwidth_Hz))*time_scale  ;   
        xlim([-limit   limit ]);

        end 

        grid on;
        set(gca,'fontsize',14,'fontweight','bold');
        
        xlabel(['Time in [',time_scale_option_input_signal,']'],...
                    'Interpreter','Latex');
        ylabel('Amplitude','Interpreter','Latex');

    case 's'
     
    plot(param_plot.t_input,param_plot.input_signal);
    grid on;
    set(gca,'fontsize',14,'fontweight','bold');
    title('Input Signal $x(t)$','Interpreter','Latex');
    xlabel('Time [s]','Interpreter','Latex');
    ylabel('Amplitude','Interpreter','Latex');
        
end 

end 

%---------------------- CTFT and DTFT ------------------------------

 case 'ctft_plot_per_fs'
  
     figure()
  
    % CTFT using fft from dowsampled samples
    % In case of aliasing
    % the CTFT plot should be wrong I guess
        
     for index_plot = 1:length(param_plot.target_Fs)
     
     range_samples = nb_samples_for_each_fs(index_plot);     
         
    subplot(1,2,index_plot)
    
    plot(param_plot.freq_vec_Hz_per_fs(index_plot,1:range_samples),...
    fftshift(param_plot.ctft_per_fs_amp(index_plot,1:range_samples)));
    xlim([-param_plot.show_freq_input param_plot.show_freq_input]);
    grid on;
    set(gca,'fontsize',14,'fontweight','bold');
    title(['Amplitude of CTFT ($x(t)$) for Fs = ',...
        num2str(param_plot.target_Fs(index_plot)),' Hz'],...
    'Interpreter','Latex');
    xlabel('Frequency (Hz)','Interpreter','Latex');
     
     end
     

% DTFT using freqz command 
% and converted CTFT from DTFT plots     
 figure()

 % In the 1st column, I plot DTFT using freqz command for
 % each target Fs
 for index_plot = 1:(length(param_plot.target_Fs))
    
    subplot(2,1,1) 
    plot(param_plot.freq_discrete_per_fs_freqz/pi,...
    abs(param_plot.dtft_comp_per_fs_freqz(index_plot,:)));
    hold on
         
 end 
 
 
     
%     xlim([-param_plot.show_freq_input param_plot.show_freq_input]);
    grid on;set(gca,'fontsize',14,'fontweight','bold');
    title('Amplitude of DTFT ($x(t)$)','Interpreter','Latex');
    xlabel('$\times \pi$ rad/sample','Interpreter','Latex');
    legend({['$F_{s_1} = $ ',num2str(param_plot.target_Fs(1)),' Hz',...
        newline '$F_{s_2} = $ ',num2str(param_plot.target_Fs(2)),' Hz']},...
    'Interpreter','latex')


% In the 2nd column, I plot the converted CTFT from DTFT
% the conversion is done upon the frequency bins
% there are 2 cases: aliased DTFT and unaliased DTFT
subplot(2,1,2)

% Plotting the unaliased signal
% which has target Fs > F_Nyquist
if strcmp(dtft_plot,'no_aliasing')
   
    
    % CTFT from DTFT 
   for index_plot = 1:(length(param_plot.target_Fs))
    
    plot(param_plot.freq_discrete_per_fs_freqz*...
    (param_plot.target_Fs(index_plot)/(2*pi)),...
    abs(param_plot.dtft_comp_per_fs_freqz(index_plot,:)));
    hold on

    end    
    
    
else
  % Here I try to plot 1 unalias case as reference 
  % and 1 alias case  
  
  % Extracting variable
    fs_to_scale = param_plot.fs_to_scale ;
  
  fprintf('--> Fs used in conversion from rad/sample --> Hz is: %d \n',...
  fs_to_scale); 
 
    freq_vec_hz_from_freqz  = ...
    param_plot.freq_discrete_per_fs_freqz*(fs_to_scale/(2*pi));
  
 % CTFT plots from DTFT using freqz command
% here I plot the CTFT of the aliased signal
% I begin form index_plot = 2 since i store
% the undersampled Fs whihc are below the Nyquist rate
% from the 2nd elemen and above in 'target_Fs' vector

    % the unalias CTFT case
    % I store it in the 1st row in dtft_comp_per_fs_freqz matrix
    plot(param_plot.freq_discrete_per_fs_freqz*...
    (param_plot.target_Fs(1)/(2*pi)),...
    abs(param_plot.dtft_comp_per_fs_freqz(1,:)));
    hold on
    % the alias CTFT case 
    % I store it in the 2nd row in dtft_comp_per_fs_freqz matrix
%     plot(freq_vec_hz_from_freqz,...
%     abs(param_plot.dtft_comp_per_fs_freqz(2,:)));


    nb_point = length(abs(param_plot.dtft_comp_per_fs_freqz(2,:)));
    
    plot(linspace(-10,10,nb_point ),...
    abs(param_plot.dtft_comp_per_fs_freqz(2,:)));

 
    
end 

 
    xlim([-param_plot.show_freq_input param_plot.show_freq_input]);
    grid on;set(gca,'fontsize',14,'fontweight','bold');
    title('Amplitude of CTFT ($x(t)$)','Interpreter','Latex');
    xlabel('$F$ [Hz]','Interpreter','Latex');
    legend({['$F_{s_1} = $ ',num2str(param_plot.target_Fs(1)),' Hz',...
        newline '$F_{s_2} = $ ',num2str(param_plot.target_Fs(2)),' Hz']},...
    'Interpreter','latex')



 

        
        
        

end

end