classdef Spectrum_Sim < handle
% Spectrum_Sim: OOP version of Sim_Spectrum.
% The simulation parameters are grouped as properties, set once in the
% constructor, and the simulation steps are methods.
%
% Usage:
%   sim = Spectrum_Sim(choice_signal="sinc", bandwidth_Hz=30);   % R2021a+
%   sim = Spectrum_Sim('choice_signal','sinc','bandwidth_Hz',30); % any version
%   sim = Spectrum_Sim();                                         % all defaults
%   sim.run();

    properties
        % ---- Signal parameters ----
        choice_signal (1,1) string = "sinc"   
        % sin, sum_of_sinusoids_2, sum_of_sinusoids_3, sinc, sinc_square, periodic_rect
        
        bandwidth_Hz  (1,1) double = 30       % Signal bandwidth in Hz
        
        signal_amp    (1,1) double = 1        % Signal amplitude

        % ---- Sampling parameters ----
        oversampling_factor (1,1) double = 5  % Fs = oversampling_factor*B (must be > 2)
        nb_samples    (1,1) double = 800
        zero_padd     (1,1) logical = true    % zero padding before fft

        % ---- Display parameters ----
        time_scale    (1,1) double = 1e3      % 1 -> s, 1e3 -> ms
        show_debug    (1,1) logical = true
    end

    properties (Dependent)
        fs  % Sampling frequency in Hz
        %  Question: what do we mean by Dependent ?
    end

    properties (SetAccess = private)
        % ---- Results ----
        time_axis
        sig_sampled
        spectr
        freq_bins
        length_fft
    end

    properties (Constant)
        signal_list = ["sin","sum_of_sinusoids_2","sum_of_sinusoids_3", ...
                       "sinc","sinc_square","periodic_rect"]
    end

    methods
        
        % constructor
        function obj = Spectrum_Sim(opts)
            
            % Name-value constructor using an arguments block (R2019b+).
            % Every option is optional: if it is not passed, it is simply
            % absent from "opts" and the property keeps the default value
            % from the properties block above (single source of defaults).
            % MATLAB checks the names, the pairing and the validators below
            % before the constructor body runs.
           
            arguments
                opts.choice_signal       (1,1) string  {mustBeMember(opts.choice_signal, ...
                    ["sin","sum_of_sinusoids_2","sum_of_sinusoids_3", ...
                     "sinc","sinc_square","periodic_rect"])}
                opts.bandwidth_Hz        (1,1) double  {mustBePositive}
                opts.signal_amp          (1,1) double
                opts.oversampling_factor (1,1) double  {mustBeGreaterThan(opts.oversampling_factor,2)}
                opts.nb_samples          (1,1) double  {mustBeInteger, mustBePositive}
                opts.zero_padd           (1,1) logical
                opts.time_scale          (1,1) double  {mustBePositive}
                opts.show_debug          (1,1) logical
            end

            % copy only the options the caller actually passed
            names = fieldnames(opts);
            for i = 1:numel(names)
                obj.(names{i}) = opts.(names{i});
            end

        end % end constructor

        function value = get.fs(obj)
            value = obj.oversampling_factor*obj.bandwidth_Hz;
        end

        function run(obj)
            obj.generateSignal();
            obj.computeSpectrum();
            obj.plot_time_Signal();
            obj.plot_spectrum();
        end % end run()

        function [time_axis,sig] = generateSignal(obj,factor)
            % Uniform sampling of the test signal; with factor > 1 it
            % returns a denser version (used to mimic continuous time).
            if nargin < 2, factor = 1; 
            
            end
            
            fs_loc = factor*obj.fs;
            N = factor*obj.nb_samples;

            % generate time axis from N samples
            time_axis = ((-N/2):(N/2 - 1))./fs_loc;
            
            sig = obj.evalSignal(time_axis);

            if nargout == 0 || factor == 1
                obj.time_axis = time_axis;
                obj.sig_sampled = sig;
                if obj.show_debug
                    fprintf('1) Start generating time signal: %s \n',obj.choice_signal)
                    fprintf('\t - Fs = %d Hz \n',obj.fs)
                    fprintf('\t - Nb of samples = %d \n',obj.nb_samples)
                    fprintf('\t - Time window = %.2f s \n',time_axis(end)-time_axis(1))
                    fprintf('=============================================== \n')
                end
            
            end % end outer if

        end % end generatSignal()

        function computeSpectrum(obj)
            if obj.zero_padd
                obj.length_fft = 2^nextpow2(obj.nb_samples);
            else
                obj.length_fft = obj.nb_samples;
            end

            obj.spectr = fftshift(fft(obj.sig_sampled,obj.length_fft));

            freq_step = obj.fs/obj.length_fft;
            obj.freq_bins = -obj.fs/2:freq_step:obj.fs/2 - freq_step;

            if obj.show_debug
                fprintf('2) Start Computing Spectrum using fft \n')
                fprintf('\t - Zero Padding option is: %d \n',obj.zero_padd)
                fprintf('\t - Length fft (Nfft) = %d \n',obj.length_fft)
                fprintf('\t - Frequency Step (Fs/Nfft)= %.2f \n',freq_step)
                fprintf('=============================================== \n')
            end

        end % end comput_spectrum()

        function plot_time_Signal(obj)
            over_sampling = 4;
            [time_cont,sig_analog] = obj.generateSignal(over_sampling);
            ts = obj.time_scale;

            figure()
            plot(time_cont*ts,sig_analog,'k'); hold on
            stem(obj.time_axis*ts,obj.sig_sampled);

            switch obj.choice_signal
                case "sin"
                    xlim([time_cont(1)*ts, ...
                          time_cont(1)*ts + (4/obj.bandwidth_Hz)*ts]);
                case "sinc"
                    limit = 6*(1/(2*obj.bandwidth_Hz))*ts;
                    xlim([-limit limit]);
            end

            grid on;
            set(gca,'fontsize',14,'fontweight','bold');
            title('Input Signal $x(t)$','Interpreter','Latex');

            % adjusting time scale for plotting
            switch obj.time_scale
                case 1,   unit = 's';
                case 1e3, unit = 'ms';
                otherwise, unit = sprintf('x%g s',1/obj.time_scale);
            end % end switch "time_scale"

            xlabel(['Time in [',unit,']'],'Interpreter','Latex');
            ylabel('Amplitude','Interpreter','Latex');
            legend({'Continous Time','Sampled'},'Interpreter','Latex')
        end % end plot_time_Signal()

        function plot_spectrum(obj)
            show_freq = obj.fs/2;

            figure()
            plot(obj.freq_bins,abs(obj.spectr));
            xlim([-show_freq show_freq]);
            grid on;
            set(gca,'fontsize',14,'fontweight','bold');
            title('Amplitude Spectrum of fft ($x(t)$)','Interpreter','Latex');
            xlabel('Frequency [Hz]','Interpreter','Latex');
        
        end % end plot_spectrum()
    
    end % end public methods

    methods (Access = private)
        
        function sig = evalSignal(obj,t)

            % compute some analytical signal based on the following input
            % - t: time axis generated at some rate Ts (Fs)
            % - B: bandwidth of the signal
            % - amp: amplitude
     
            % unpacking some parameters to make code more readable
            B = obj.bandwidth_Hz;
            amp = obj.signal_amp;
            
            offset_freq = 0.5*B;
            offset_freq_2 = 0.25*B;

            switch obj.choice_signal
            
                case "sin"
                    sig = amp*sin(2*pi*B*t);
                
                case "sum_of_sinusoids_2"
                    sig = amp*sin(2*pi*B*t) + ...
                          amp*sin(2*pi*(B - offset_freq)*t);
                
                case "sum_of_sinusoids_3"
                    sig = amp*sin(2*pi*B*t) + ...
                          amp*sin(2*pi*(B - offset_freq)*t) + ...
                          amp*cos(2*pi*(B - offset_freq - offset_freq_2)*t);
                
                case "sinc"
                    sig = 2*B*sinc(2*B*t);
                
                case "sinc_square"
                    sig = B*(sinc(B*t)).^2;
                
                case "periodic_rect"
                    sig = square(2*pi*B*t,50);
            
            end % end switch 
    
        end % end evalSignal(obj,t)
    
    end % end private methods


end % end class Spectrum_Sim
