function y = sincInterpolation(x,t,u,varargin)
    % Interpolates x sampled sampled at "t" instants
    % Output y is sampled at "u" instants ("u" for "upsampled")
    
    if ~isempty(varargin)
        displayN = varargin{1};
    else
        displayN = 1e50;
    end
    displayCounter = 1;

    % Find the sampling period of the undersampled signal
    T = t(2)-t(1);
    
    %initialize variable
    y = zeros(1,numel(u));

    %sinc interpolation is weighted superposition of time-shifted sinc
    %functions
    for i=1:length(u)
        if mod(i,displayN) == 0
            if displayCounter == 10
                fprintf([num2str(i) '... \n']);
                displayCounter = 0;
            else
                fprintf([num2str(i) '...']);
            end
            displayCounter = displayCounter + 1;
                
        end
        y( i ) = sum( x .* sinc( (1/T)*(u(i) - t) ) );
    end

end