%% task 2
tr_piano=16; % record time in seconds
y=audioread('music1.wav'); Fs=length(y)/tr_piano;
plot((1:length(y))/Fs,y);
xlabel('Time [sec]'); ylabel('Amplitude');
title('Mary had a little lamb (piano)'); drawnow
% p8 = audioplayer(y,Fs); playblocking(p8);
S = y';
t = (1:length(y))/Fs;
dt = 0.1;
Nfft = length(t);
df = Fs/Nfft;
f = (0:(Nfft-1))*df;
keep = (f >= 700 & f < 1200);
% keep = (f >= 10 & f < 5000);
% f(f >= Fs/2) = f(f >= Fs/2) - Fs;
tslide=0:dt:t(end);
width = [0.2, 2, 10, 30, 100, 200, 500, 1000, 5000, 10000, 100000, 1000000];
for itr = 4:4
    wid = width(itr);
    Sgt_spec=[]; 
    for j=1:length(tslide)
        g = Windowfunction(wid,tslide(j),t,"Gaussian");
        Sg=g.*S; 
        Sgt=fft(Sg); 
        Sgt=Sgt(keep);    
        Sgt_spec=[Sgt_spec; abs(Sgt)]; 
        subplot(3,1,1), plot(t,S,'k',t,g,'r');
        xlabel('time/sec');ylabel('audioMag/unit');ntitle('Raw Audio and Filter','fontsize',14);
        legend('raw data','filter');set(gca,'FontSize',14);
        subplot(3,1,2), plot(t,Sg,'k')
        xlabel('time/sec');ylabel('audioMag/unit');ntitle('Windowed computation result','fontsize',14);
        set(gca,'FontSize',14);
        subplot(3,1,3), plot(f(keep),abs(Sgt)/max(abs(Sgt))) 
        xlabel('freq/hz');ylabel('FreqMagnitude/unit');ntitle('Normalized FFT analysis','fontsize',14);
        legend('Fs = 43840 hz');set(gca,'FontSize',14);
        % axis([-50 50 0 1])
        drawnow
        pause(0.1)
    end
    figure()
    pcolor(tslide,f(keep),log(Sgt_spec.'))
    xlabel('time/sec');ylabel('freq/hz');title(['Spectrogram of piano version with Gaussian filter']);
    shading interp 
    set(gca,'Ylim',[700 1200],'Fontsize',[14]) 
    set(gca, 'FontSize', 14)
    colormap(hot)
%     saveas(gcf,['Spectrogram with StepSize Filter width =', num2str(wid), 'dt = ' num2str(dt) '.jpg']);
end
%%
f_array = f(keep);
Info = Sgt_spec;
[M,I] = max(Info);
peak_f = f_array(I);
    


%%
%% task 2
tr_piano=14; % record time in seconds
y=audioread('music2.wav'); Fs=length(y)/tr_piano;
plot((1:length(y))/Fs,y);
xlabel('Time [sec]'); ylabel('Amplitude');
title('Mary had a little lamb (piano)'); drawnow
% p8 = audioplayer(y,Fs); playblocking(p8);

S = y';
t = (1:length(y))/Fs;
dt = 0.1;
Nfft = length(t);
df = Fs/Nfft;
f = (0:(Nfft-1))*df;
keep = (f >= 700 & f < 1200);
% keep = (f >= 10 & f < 5000);
% f(f >= Fs/2) = f(f >= Fs/2) - Fs;
tslide=0:dt:t(end);
width = [0.2, 2, 10, 30, 100, 200, 500, 1000, 5000, 10000, 100000, 1000000];
for itr = 4:4
    wid = width(itr);
    Sgt_spec=[]; 
    for j=1:length(tslide)
        
%         g=exp(-wid*(t-tslide(j)).^2); % Gabor
        g = Windowfunction(wid,tslide(j),t,"Gaussian");
        Sg=g.*S; 
        Sgt=fft(Sg); 
        Sgt=Sgt(keep);
%         Sgt= 2*Sgt;
        
        
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
        legend('Fs = 44837 hz');set(gca,'FontSize',14);
        % axis([-50 50 0 1])
        drawnow
        pause(1)
    end

    figure()
    pcolor(tslide,f(keep),log(Sgt_spec.'))
    xlabel('time/sec');ylabel('freq/hz');title(['Spectrogram of recorder version with Gaussian filter']);
    shading interp 
    set(gca,'Ylim',[700 1200],'Fontsize',[14]) 
    set(gca, 'FontSize', 14)
    colormap(hot)

    
%     saveas(gcf,['Spectrogram with StepSize Filter width =', num2str(wid), 'dt = ' num2str(dt) '.jpg']);
end