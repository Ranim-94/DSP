

function make_plots(what_to_plot,param_plot,how_many)

nb_of_samples = param_plot.nb_of_samples;

time_scale_option_input_signal = param_plot.time_scale_option_input_signal;

switch what_to_plot

    case 'ctft_plot'
   
        
figure()
subplot(1,3,1)


switch time_scale_option_input_signal
    
    
    case {'ms','micros'}

%plot time axis in ms --> multiply bu 10^3 = 1e3
plot(param_plot.t_input*1e3,param_plot.input_signal);

xlim([param_plot.start_time*1e3  param_plot.start_time*1e3 + param_plot.show_time]);
grid on;
set(gca,'fontsize',14,'fontweight','bold');
title('Input Signal $x(t)$','Interpreter','Latex');
xlabel('Time [ms]','Interpreter','Latex');
ylabel('Amplitude','Interpreter','Latex');



    case 's'
     
plot(param_plot.t_input,param_plot.input_signal);
grid on;
set(gca,'fontsize',14,'fontweight','bold');
title('Input Signal $x(t)$','Interpreter','Latex');
xlabel('Time [s]','Interpreter','Latex');
ylabel('Amplitude','Interpreter','Latex');
        
        
end 

subplot(1,3,2)
% Ampitude of CTFT using FFT
plot(param_plot.freq_vector_input,...
fftshift(param_plot.ctft_input_amp/nb_of_samples));
xlim([-param_plot.show_freq_input param_plot.show_freq_input]);
grid on;
set(gca,'fontsize',14,'fontweight','bold');
title('CTFT of $x(t)$','Interpreter','Latex');
xlabel('Frequency (Hz)','Interpreter','Latex');
ylabel('Amplitude Spectrum','Interpreter','Latex');


% Phase Spectrum

subplot(1,3,3)

plot(param_plot.freq_vector_input,fftshift(param_plot.ctft_input_phase_Deg));

xlim([-param_plot.show_freq_input param_plot.show_freq_input]);
grid on;
set(gca,'fontsize',14,'fontweight','bold');
title('CTFT of $x(t)$','Interpreter','Latex');
xlabel('Frequency (Hz)','Interpreter','Latex');
ylabel('Phase Spectrum in degree','Interpreter','Latex');


    case 'Channel_Measurements'

   % Extracting nb of samples for input signal and measu in channels     
  nb_of_samples = param_plot.nb_of_samples ;     
       
   
   nb_of_samples_meas = param_plot.nb_samples_meas ; 
   
    figure()

    % Analog Input signal
    subplot(1,3,1)
    plot(param_plot.t_input*1e3,param_plot.input_signal);
    hold on;

    % dispalying first 2 channels in time domain before downsampling
    % just the delays in analog time 
    for index = 1:2
    plot(param_plot.t_input*1e3,param_plot.dealyed_signals(index,:));
    hold on 
    end
    xlim([-param_plot.show_time param_plot.show_time]);
    
    grid on;
    set(gca,'fontsize',14,'fontweight','bold');
    title('Delayed Measurements','Interpreter','Latex');
    xlabel('Time [ms]','Interpreter','Latex');
    ylabel('Amplitude','Interpreter','Latex');
    legend({'Input Signal','Ch1','Ch2'},'Interpreter','Latex');


    % CTFT of the measurements: after downsampling,
    % so aliasing will appear
    
    subplot(1,3,2)

    % Ampliude Spectrum of input signal
plot(param_plot.freq_vector_input,...
fftshift(param_plot.ctft_input_amp/nb_of_samples));
xlim([-param_plot.show_freq_input param_plot.show_freq_input]);
hold on,    


    % Plotting Amp of the first 2 channels
    for index = 1:2
    plot(param_plot.freq_vec_channels(index,:),...
    fftshift(param_plot.ctft_channels_amp(index,:)/nb_of_samples_meas));
    hold on 
    end 

    xlim([-param_plot.show_freq param_plot.show_freq]);
    grid on;
    set(gca,'fontsize',14,'fontweight','bold');
    title('Amp Spectrum of CTFT','Interpreter','Latex');
    xlabel('Frequency (Hz)','Interpreter','Latex');
    legend({'Input Signal','Ch1','Ch2'},'Interpreter','Latex');

    
    % Phase Spectrum
    subplot(1,3,3)

    % Phase of the Input Signal
    plot(param_plot.freq_vector_input,fftshift(param_plot.ctft_input_phase_Deg)); 
    hold on;
    
    % Phase of the measurement
    for index = 1:2
    plot(param_plot.freq_vec_channels(index,:),...
    fftshift(param_plot.ctft_channels_phase(index,:))) ;
    hold on 
    end 

    xlim([-param_plot.show_freq param_plot.show_freq]);
    grid on;
    set(gca,'fontsize',14,'fontweight','bold');
    title('CTFT of Measurements','Interpreter','Latex');
    xlabel('Frequency (Hz)','Interpreter','Latex');
    ylabel('Phase Spectrum in degree','Interpreter','Latex');
    legend({'Input Signal','Ch1','Ch2'},'Interpreter','Latex');
    

case 'Channel_Measurements_all'

    
    
   % Extracting nb of samples for input signal and measu in channels     
  nb_of_samples = param_plot.nb_of_samples ;
  
  time_scale = param_plot.time_scale ;
      
   nb_of_samples_meas = param_plot.nb_samples_meas ; 
   
   
   
   gain_channels = param_plot.gain_channels;
   
    figure()

    % Analog Input signal
    subplot(2,2,1)
    
    % time axis in ms --> *10^3
    plot(param_plot.t_input*time_scale,param_plot.input_signal);
    xlim([param_plot.start_time*time_scale  param_plot.timeMeas_matrix(1,10)*time_scale + param_plot.show_time]);
    grid on;set(gca,'fontsize',14,'fontweight','bold');
    title('Input Signal','Interpreter','Latex');

    
%     show_plot_ch_time = param_plot.start_time*time_scale + ...
%                     4*max(param_plot.delayed_channels)*time_scale;
       
    
    % dispalying first 2 channels in time domain before downsampling
    % just the delays in analog time 
    for index = 1:how_many
    subplot(2,2,index+1)    
    % plot time axis in ms --> *1e3
    plot(param_plot.t_input*time_scale,...
    gain_channels(index)*param_plot.dealyed_signals(index,:));
    hold on
    % plot time axis in ms --> *1e3
    stem(param_plot.timeMeas_matrix(index,:).*time_scale,param_plot.meas_matrix(index,:))
    xlim([param_plot.start_time*time_scale  param_plot.timeMeas_matrix(index,10)*time_scale]);
    
    grid on;
    set(gca,'fontsize',14,'fontweight','bold');
    title(['Delayed Measurements of Ch',num2str(index)],...
        'Interpreter','Latex');
    xlabel('Time [ms]','Interpreter','Latex');
    
    
    
    end
   


    % CTFT of the measurements: after downsampling,
    % so aliasing will appear
    
    figure()
    
    subplot(2,2,1)

    % Ampliude Spectrum of input signal
    plot(param_plot.freq_vector_input,...
    fftshift(param_plot.ctft_input_amp/nb_of_samples));
    xlim([-param_plot.show_freq_input param_plot.show_freq_input]);
    grid on;set(gca,'fontsize',14,'fontweight','bold');
    xlabel('Frequency (Hz)','Interpreter','Latex');
    title('Amp Spectrum of Input Signal','Interpreter','Latex');  


    % Plotting Amp of the first 2 channels
    for index = 1:how_many
        
    subplot(2,2,index+1)
    plot(param_plot.freq_vec_channels(index,:),...
    fftshift(param_plot.ctft_channels_amp(index,:)/nb_of_samples_meas));
    title(['Amp Spectrum of CTFT for Ch ',num2str(index)],...
    'Interpreter','Latex');
    hold on
    xlim([-param_plot.show_freq param_plot.show_freq]);
    grid on;
    set(gca,'fontsize',14,'fontweight','bold');
    xlabel('Frequency (Hz)','Interpreter','Latex');
    
    end 

    
  

    
    figure()
    % Phase Spectrum
    subplot(2,2,1)

    % Phase of the Input Signal
    plot(param_plot.freq_vector_input,fftshift(param_plot.ctft_input_phase_Deg)); 
    title('Phase Spectrum of Input Signal','Interpreter','Latex');
    xlim([-param_plot.show_freq param_plot.show_freq]);
    grid on;set(gca,'fontsize',14,'fontweight','bold');
    xlabel('Frequency (Hz)','Interpreter','Latex');
    
    
    % Phase of the measurement
    for index = 1:how_many
    
    subplot(2,2,index+1)
    plot(param_plot.freq_vec_channels(index,:),...
    fftshift(param_plot.ctft_channels_phase(index,:))) ;
    title(['Phase Spectrum of CTFT for Ch ',num2str(index)],...
    'Interpreter','Latex');
    xlim([-param_plot.show_freq param_plot.show_freq]);
    grid on;set(gca,'fontsize',14,'fontweight','bold');
    xlabel('Frequency (Hz)','Interpreter','Latex');
    
    end 

   
    
end % switch cases




end % function