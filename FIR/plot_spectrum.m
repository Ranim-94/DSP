

function plot_spectrum(sig_spect,freq_axis,title_content)



scale_freq_axis = 1e3; % to scale from Hz -> KHz

% convert from Hz -> KHz and multiplyin by 2, to zoom in
%limit_freq = 2*(limit_freq/scale_freq_axis); 

% Amplitude Spectrum
figure()
plot(freq_axis./scale_freq_axis,abs(sig_spect));
grid on;
set(gca,'fontsize',14,'fontweight','bold');
ylabel('Amp','Interpreter','Latex');
xlabel('Frequency [KHz]','Interpreter','Latex');
title(title_content,'Interpreter','Latex');
%xlim([-limit_freq  limit_freq ]);




end % end function

