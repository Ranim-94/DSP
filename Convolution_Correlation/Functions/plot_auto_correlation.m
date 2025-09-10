

function plot_auto_correlation(t_input,Rxx)

% time domain plot for a rectangular pulse
figure()
plot(t_input,Rxx);
xlim([-t_input(end) t_input(end)]);
grid on;
set(gca,'fontsize',14,'fontweight','bold');
title('$R_{xx}(\tau)$','Interpreter','Latex');
xlabel('Time [s]','Interpreter','Latex');
ylabel('Amplitude','Interpreter','Latex')


end % end function