%% task 1
% try different width of the filter
% try different translation resolution of the Garbor filter
% try different types of filter
iptsetpref('ImshowBorder','tight');
load handel
v = y'/2; figure();
plot((1:length(v))/Fs,v);
xlabel('Time [sec]');
ylabel('Amplitude');
title('Signal of Interest, v(n)');

% 0.01, 0.05, 0.1, 0.2, 0.5, 1
dt_array = [0.001, 0.01, 1, 0.05, 0.1, 0.2, 0.5, 1];
% dt = 0.01;
t = (1:length(v))/Fs;
S = v;
Nfft = length(t);
df = Fs/Nfft;
f = (0:(Nfft-1))*df;
f(f >= Fs/2) = f(f >= Fs/2) - Fs;
% frequency range in men and women voice
keep = (f >= 130 & f < 1200);

% width choices for Gaussian
% width = [0.2, 2, 10, 30, 100, 200, 500, 1000, 5000, 10000, 100000, 1000000];
width = [10, 30, 200, 500, 5000, 100000];
% width choices for MexicanHat
% width = [0.001, 0.005, 0.01, 0.04, 0.06, 0.1, 0.3, 1];
% width = [0.001, 0.01, 0.04, 0.06, 0.1, 1];
% width choices for StepSize Function
% width = [0.01, 0.04, 0.06, 0.08, 0.1, 1];
% width = [0.001, 0.01, 0.04, 0.08, 0.1, 1];
for ii = 2:3
dt = dt_array(ii);
tslide=0:dt:t(end);
for itr = 3:3
    wid = width(itr);
    Sgt_spec=[]; 
    for j=1:length(tslide)
        
%         g=exp(-wid*(t-tslide(j)).^2); % Gabor
        g = Windowfunction(wid,tslide(j),t,"Gaussian");
        Sg=g.*S; 
        Sgt=fft(Sg); 
        Sgt=Sgt(keep);
        Sgt= 2*Sgt;
        Sgt_spec=[Sgt_spec; 
        abs(Sgt)]; 
        subplot(3,1,1), plot(t,S,'k',t,g,'r');
        xlabel('time/sec');ylabel('audioMag/unit');ntitle('Raw Audio and Filter','fontsize',14);
        legend('raw data','filter');set(gca,'FontSize',14);
        subplot(3,1,2), plot(t,Sg,'k')
        xlabel('time/sec');ylabel('audioMag/unit');ntitle('Windowed computation result','fontsize',14);
        set(gca,'FontSize',14);
        subplot(3,1,3), plot(f(keep),abs(Sgt)/max(abs(Sgt))) 
        xlabel('freq/hz');ylabel('FreqMagnitude/unit');ntitle('Normalized FFT analysis','fontsize',14);
        legend('Fs = 8192 hz');set(gca,'FontSize',14);
        % axis([-50 50 0 1])
        drawnow
        pause(0.1)
%         return
    end

    figure()
    pcolor(tslide,f(keep),Sgt_spec.')
    xlabel('time/sec');ylabel('freq/hz');title(['Spectrogram with Gaussian filter width =', num2str(wid), ' dt = ' num2str(dt) ]);
    shading interp 
    % set(gca,'Ylim',[-50 50],'Fontsize',[14]) 
    set(gca, 'FontSize', 14)
    colormap(hot)
%     return
    saveas(gcf,['Spectrogram with Gaussian Filter width =', num2str(wid), 'dt = ' num2str(dt)  '.jpg']);
end
% 'dt = ' num2str(dt) 
end