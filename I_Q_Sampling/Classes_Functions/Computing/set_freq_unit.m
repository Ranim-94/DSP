

function unit_freq = set_freq_unit(scale_freq)

% Description: set freq unit to work in different bands Hz,KHz,MHz,

switch scale_freq
    
    case 1 % Hz
        
        unit_freq = 'Hz';
    
    case 1e3 % MHz
        
        unit_freq = 'KHz';
        
    case 1e6 % MHz
        
        unit_freq = 'MHz';
        
    
end % End switch case


end