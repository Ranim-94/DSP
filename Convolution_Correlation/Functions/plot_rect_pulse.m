

function plot_rect_pulse(t_input,signal_rect,rect_pulse_width,choice_plot)

if strcmp(choice_plot,'no_delay')

% time domain plot for a rectangular pulse
figure()
plot(t_input,signal_rect);
xlim([-t_input(end) t_input(end)]);
grid on;
set(gca,'fontsize',14,'fontweight','bold');
title(['Rectangular pulse of width ',num2str(rect_pulse_width)],...
'Interpreter','Latex');
xlabel('Time [s]','Interpreter','Latex');
ylabel('Amplitude','Interpreter','Latex')

elseif strcmp(choice_plot,'delay')

    
 % time domain plot for a rectangular pulse
 
sentence_1 = strcat('Rectangular pulse of width  ',num2str(rect_pulse_width)) ;

sentence_2 = "delay = 50 s"; 

figure()
plot(t_input,signal_rect);
xlim([-t_input(end) t_input(end)]);
grid on;
set(gca,'fontsize',14,'fontweight','bold');
title([sentence_1,sentence_2],'Interpreter','Latex');
xlabel('Time [s]','Interpreter','Latex');
ylabel('Amplitude','Interpreter','Latex')
    
end % end if-else selection


end % end function