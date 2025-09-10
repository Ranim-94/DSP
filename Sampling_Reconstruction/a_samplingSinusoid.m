close all; 

%set time vector and frequency for "continous-time" sinusoid
tMax = 5;
t    = 0:0.0001:tMax;
f    = 2;

%set sampling rate for sampled sinusoid
fs    = 2.5;
tSamp = 0:1/fs:tMax;

%create "continuous" and sampled signals
xCont = cos(2*pi*f*t);
xSamp = cos(2*pi*f*tSamp);

figure;
hold on;
set(gca,'fontsize',14,'fontweight','bold');
plot(t,xCont,'b','linewidth',2);
plot(tSamp,xSamp,'ko','linewidth',2);

%compute aliased frequency
if fs <= 2*f
    
    %determine aliased frequency
    keepGoing = 1;
    m         = 0;
    while(keepGoing)
        fAlias = abs(f-m*fs);
        if fAlias <= fs/2
            keepGoing = 0;
        else
            m = m+1;
        end
    end
    %plot aliased sinusoid
    plot(t,cos(2*pi*fAlias*t),'r','linewidth',2);
    title(['Aliased Frequency ' num2str(fAlias) ' Hz']);
else
    title('No Aliasing');
end

ylim([-1.3 1.3]);
grid on;
xlabel('Time (s)');