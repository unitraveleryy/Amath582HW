%% data alignment
xy_cam1 = importdata('pos_rec/xy_cam1_1.mat');
xy_cam2 = importdata('pos_rec/xy_cam2_1.mat');
xy_cam3 = importdata('pos_rec/xy_cam3_1.mat');

figure();
plot(xy_cam1(1,:),xy_cam1(2,:),'-*');
figure();
plot(xy_cam2(1,1:226),xy_cam2(2,1:226),'-*');
figure();
plot(xy_cam3(1,:),xy_cam3(2,:),'-*');

%% task I
% cam1, cam2 1:226 cam3 8:end
xy_cam1 = importdata('pos_rec/xy_cam1_1.mat');
xy_cam2 = importdata('pos_rec/xy_cam2_1.mat');
xy_cam3 = importdata('pos_rec/xy_cam3_1.mat');
xy_cam2 = xy_cam2(:,10:226+9); xy_cam3 = xy_cam3(:,1:226);

X = [xy_cam1;xy_cam2;xy_cam3];
[m,n] = size(X);
mn = mean(X,2);
X = X - repmat(mn,1,n);
[u,s,v]=svd(X/sqrt(n-1));
Y = u' * X;
sig = diag(s);
sig(1)/sum(sig)

figure()
sig=diag(s);
subplot(3,2,1), plot(1:6,sig,'ko','Linewidth',[1.5])
% axis([0 25 0 50])
% set(gca,'Fontsize',[13],'Xtick',[0 5 10 15 20 25]) 
text(5,70,'(a)','Fontsize',[13])
subplot(3,2,2), semilogy(1:6,sig,'ko','Linewidth',[1.5])
% axis([0 25 10^(-18) 10^(5)])
% set(gca,'Fontsize',[13],'Ytick',[10^(-15) 10^(-10) 10^(-5) 10^0 10^5],...
%   'Xtick',[0 5 10 15 20 25]); 
text(5,10^1.5,'(b)','Fontsize',[13])

subplot(3,1,2) % spatial modes 
plot(1:6,u(:,1),'ko-','Linewidth',[2]) 
set(gca,'Fontsize',[13])
legend('mode 1','Location','NorthWest') 
text(5,0.4,'(c)','Fontsize',[13])
subplot(3,1,3) % time behavior 
plot(1:length(xy_cam1),v(:,1),'k','Linewidth',[2]) 
text(220,0,'(d)','Fontsize',[13])

figure();plot(Y(1,:)); title("Time Evolution of the Y Principle Direction");
xlabel('Index of Time Stamp');ylabel('translation in pixels');
%% task II
% cam1, cam2 1:226 cam3 8:end
xy_cam1 = importdata('pos_rec/xy_cam1_2.mat');
xy_cam2 = importdata('pos_rec/xy_cam2_2.mat');
xy_cam3 = importdata('pos_rec/xy_cam3_2.mat');
xy_cam1 = xy_cam1(:,12:314-3);xy_cam2 = xy_cam2(:,1:314-14); xy_cam3 = xy_cam3(:,15:314);

X = [xy_cam1;xy_cam2;xy_cam3];
[m,n] = size(X);
mn = mean(X,2);
X = X - repmat(mn,1,n);
[u,s,v]=svd(X/sqrt(n-1));
Y = u' * X;
sig = diag(s);
sig(1)/sum(sig)

figure()
sig=diag(s);
subplot(3,2,1), plot(1:6,sig,'ko','Linewidth',[1.5])
% axis([0 25 0 50])
% set(gca,'Fontsize',[13],'Xtick',[0 5 10 15 20 25]) 
text(5,50,'(a)','Fontsize',[13])
subplot(3,2,2), semilogy(1:6,sig,'ko','Linewidth',[1.5])
% axis([0 25 10^(-18) 10^(5)])
% set(gca,'Fontsize',[13],'Ytick',[10^(-15) 10^(-10) 10^(-5) 10^0 10^5],...
%   'Xtick',[0 5 10 15 20 25]); 
text(5,10^1.5,'(b)','Fontsize',[13])

subplot(3,1,2) % spatial modes 
plot(1:6,u(:,1),'ko-',1:6,u(:,2),'ko--','Linewidth',[2]) 
set(gca,'Fontsize',[13])
legend('mode 1','mode 2','Location','NorthWest') 
text(5,-0.4,'(c)','Fontsize',[13])
subplot(3,1,3) % time behavior 
plot(1:length(xy_cam1),v(:,1),'k',1:length(xy_cam1),v(:,2),'k--','Linewidth',[2]) 
text(220,-0.1,'(d)','Fontsize',[13])
legend('mode 1','mode 2','Location','NorthWest') 
figure();plot(Y(1,:)); title("Time Evolution of the Y Principle Direction");
xlabel('Index of Time Stamp');ylabel('translation in pixels');
%% task III
% cam1, cam2 1:226 cam3 8:end
xy_cam1 = importdata('pos_rec/xy_cam1_3.mat');
xy_cam2 = importdata('pos_rec/xy_cam2_3.mat');
xy_cam3 = importdata('pos_rec/xy_cam3_3.mat');
xy_cam1 = xy_cam1(:,7:237);xy_cam2 = xy_cam2(:,36:237+29); xy_cam3 = xy_cam3(:,1:237-6);

X = [xy_cam1;xy_cam2;xy_cam3];
[m,n] = size(X);
mn = mean(X,2);
X = X - repmat(mn,1,n);
[u,s,v]=svd(X/sqrt(n-1));
Y = u' * X;
sig = diag(s);
sig(1)/sum(sig)

figure()
sig=diag(s);
subplot(3,2,1), plot(1:6,sig,'ko','Linewidth',[1.5])
% axis([0 25 0 50])
% set(gca,'Fontsize',[13],'Xtick',[0 5 10 15 20 25]) 
text(5,50,'(a)','Fontsize',[13])
subplot(3,2,2), semilogy(1:6,sig,'ko','Linewidth',[1.5])
% axis([0 25 10^(-18) 10^(5)])
% set(gca,'Fontsize',[13],'Ytick',[10^(-15) 10^(-10) 10^(-5) 10^0 10^5],...
%   'Xtick',[0 5 10 15 20 25]); 
text(5,10^1.5,'(b)','Fontsize',[13])

subplot(3,1,2) % spatial modes 
plot(1:6,u(:,1),'ko-',1:6,u(:,2),'ko--','Linewidth',[2]) 
set(gca,'Fontsize',[13])
legend('mode 1','mode 2','Location','NorthWest') 
text(5,0.8,'(c)','Fontsize',[13])
subplot(3,1,3) % time behavior 
plot(1:length(xy_cam1),v(:,1),'k',1:length(xy_cam1),v(:,2),'k--','Linewidth',[2]) 
text(220,-0.1,'(d)','Fontsize',[13])
legend('mode 1','mode 2','Location','NorthWest') 
figure();plot(Y(1,:)); title("Time Evolution of the Y_1 Principle Direction");
xlabel('Index of Time Stamp');ylabel('translation in pixels');
figure();plot(Y(2,:)); title("Time Evolution of the Y_2 Principle Direction");
xlabel('Index of Time Stamp');ylabel('translation in pixels');
%% task IV
% cam1, cam2 1:226 cam3 8:end
xy_cam1 = importdata('pos/xy_cam1_4.mat');
xy_cam2 = importdata('pos/xy_cam2_4.mat');
xy_cam3 = importdata('pos/xy_cam3_4.mat');
xy_cam1 = xy_cam1(:,12:392);xy_cam2 = xy_cam2(:,20:392+8); xy_cam3 = xy_cam3(:,14:392+2);

X = [xy_cam1;xy_cam2;xy_cam3];
[m,n] = size(X);
mn = mean(X,2);
X = X - repmat(mn,1,n);
[u,s,v]=svd(X/sqrt(n-1));
Y = u' * X;
sig = diag(s);
sig(1)/sum(sig)

figure()
sig=diag(s);
subplot(3,2,1), plot(1:6,sig,'ko','Linewidth',[1.5])
% axis([0 25 0 50])
% set(gca,'Fontsize',[13],'Xtick',[0 5 10 15 20 25]) 
text(5,50,'(a)','Fontsize',[13])
subplot(3,2,2), semilogy(1:6,sig,'ko','Linewidth',[1.5])
% axis([0 25 10^(-18) 10^(5)])
% set(gca,'Fontsize',[13],'Ytick',[10^(-15) 10^(-10) 10^(-5) 10^0 10^5],...
%   'Xtick',[0 5 10 15 20 25]); 
text(5,10^1.5,'(b)','Fontsize',[13])

subplot(3,1,2) % spatial modes 
plot(1:6,u(:,1),'ko-',1:6,u(:,2),'ko--','Linewidth',[2]) 
set(gca,'Fontsize',[13])
legend('mode 1','mode 2','Location','NorthWest') 
text(5,0.8,'(c)','Fontsize',[13])
subplot(3,1,3) % time behavior 
plot(1:length(xy_cam1),v(:,1),'k',1:length(xy_cam1),v(:,2),'k--','Linewidth',[2]) 
text(350,0.18,'(d)','Fontsize',[13])
legend('mode 1','mode 2','Location','NorthWest') 
figure();plot(Y(1,:)); title("Time Evolution of the Y_1 Principle Direction");
xlabel('Index of Time Stamp');ylabel('translation in pixels');
figure();plot(Y(2,:)); title("Time Evolution of the Y_2 Principle Direction");
xlabel('Index of Time Stamp');ylabel('translation in pixels');
%%

figure();plot(1:6,sig);title("Singular Values");
figure();semilogy(1:6,sig);title("Singular Values in log scale");
figure();plot(1:6,u(:,1));title("Principle Mode");

figure();plot(1:length(xy_cam1),v(:,1));title("Time Evolution of the Corresponding Mode");
figure();plot(Y(1,:)); title("Time Evolution of the Y Principle Direction");
%%
Y = u' * X;


figure();plot(Y(1,:));
figure();plot(Y(2,:));
figure();plot(v(:,1));
figure();plot(v(:,2));
%% demo task I
cam1 = importdata('cam1_1.mat');
cam2 = importdata('cam2_1.mat');
cam3 = importdata('cam3_1.mat');
xy_cam1 = importdata('pos_rec/xy_cam1_1.mat');
xy_cam2 = importdata('pos_rec/xy_cam2_1.mat');
xy_cam3 = importdata('pos_rec/xy_cam3_1.mat');

frame = cam1(:,:,:,100);
figure();imshow(frame);hold on;scatter(xy_cam1(2,:),xy_cam1(1,:));
xy_mean = mean(xy_cam1,2);
plot([xy_mean(2) xy_mean(2)+0.038*20],[xy_mean(1) xy_mean(1)+5.452*20],'LineWidth',5);
plot([xy_mean(2) xy_mean(2)-0.306*20],[xy_mean(1) xy_mean(1)-0.3158*20],'g','LineWidth',5);
%% demo task III
cam1 = importdata('cam1_3.mat');
cam2 = importdata('cam2_3.mat');
cam3 = importdata('cam3_3.mat');
xy_cam1 = importdata('pos_rec/xy_cam1_3.mat');
xy_cam2 = importdata('pos_rec/xy_cam2_3.mat');
xy_cam3 = importdata('pos_rec/xy_cam3_3.mat');

frame = cam1(:,:,:,100);
figure();imshow(frame);hold on;scatter(xy_cam1(2,:),xy_cam1(1,:));
xy_mean = mean(xy_cam1,2);
plot([xy_mean(2) xy_mean(2)-0.0055*30],[xy_mean(1) xy_mean(1)-0.4936*30],'LineWidth',5);
plot([xy_mean(2) xy_mean(2)+0.3089*30],[xy_mean(1) xy_mean(1)+0.1749*30],'g','LineWidth',5);