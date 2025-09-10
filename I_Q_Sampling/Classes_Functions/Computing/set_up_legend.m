

function legend_analog_modulation = set_up_legend(modulation_type)

if strcmp(modulation_type,'DSB_SC')
    
    legend_analog_modulation = "DSB SC" ;
    
elseif strcmp(modulation_type,'SSB_U')
    
    legend_analog_modulation = "SSB U" ;
    
elseif strcmp(modulation_type,'SSB_L')
    
    legend_analog_modulation = "SSB L" ;
    
elseif strcmp(modulation_type,'FM')
    
    legend_analog_modulation = 'FM' ;    
    
    
end % End if comparison


end % End function