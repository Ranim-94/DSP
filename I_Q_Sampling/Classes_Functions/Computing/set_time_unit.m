


function time_scale_string = set_time_unit(time_scale)

% Description: set time scale for printing and plotting,
% return a string type

if time_scale == 1e3
time_scale_string = 'ms';

elseif time_scale == 1e6
    
    time_scale_string = 'micros';
    
else
    time_scale_string = 's';
    
end % End if



end % End function