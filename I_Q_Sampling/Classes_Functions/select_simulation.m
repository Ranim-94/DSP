



function out_sim = select_simulation(param_sim,demo_choice)


switch demo_choice
    
    case 'IQ'
    
    
        % Instantion of the class
    iq = Interface_IQ(param_sim);


    % Start Simulation
    out_sim =  iq.start_sim();
    
    
    
    case 'fft_demo'
    
        % Instantion of the class
    fft_interface = Interface_fft(param_sim);


    % Start Simulation
    out_sim =  fft_interface.start_sim();
    
    
    
    
    case 'multiple_period'
    
    
    multiple_period = Interface_multiple_sampling_period(param_sim);
    
    
    out_sim = multiple_period.start_sim();
    
    
     case 'bin_leakage'
    
    
    leakage = Interface_bin_leakge(param_sim);
    
    
    out_sim = leakage.start_sim();
    
    
    
    
end 


end