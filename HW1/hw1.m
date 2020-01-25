% clear all; close all; clc;
load Testdata
L=15; % spatial domain
n=64; % Fourier modes
x2=linspace(-L,L,n+1); x=x2(1:n); y=x; z=x;
k=(2*pi/(2*L))*[0:(n/2-1) -n/2:-1]; ks=fftshift(k);
[X,Y,Z]=meshgrid(x,y,z);
% [Kx,Ky,Kz]=meshgrid(ks,ks,ks);
[Kx,Ky,Kz]=meshgrid(k,k,k);

% frequency spectrum averaging
Unt_accumulate = zeros(n,n,n);
for j=1:20
    Un(:,:,:)=reshape(Undata(j,:),n,n,n);
    Unt = fftn(Un);
    Unt_accumulate = Unt_accumulate + Unt;
end

Unt_average = Unt_accumulate./20;


% build the frequency filter
[~, idx] = max(abs(Unt_average(:)));
Kx_tmp = Kx(:); fx = Kx_tmp(idx);
Ky_tmp = Ky(:); fy = Ky_tmp(idx);
Kz_tmp = Kz(:); fz = Kz_tmp(idx);
tau = 1;
filter = exp(-tau*((Kx - fx).^2 + (Ky - fy).^2 + (Kz - fz).^2));

% initializing the memory
X_tmp = X(:); Y_tmp = Y(:); Z_tmp = Z(:);
X_record = zeros(1,20); Y_record = zeros(1,20); Z_record = zeros(1,20);

% filtering each meausrement
for j =1:20
    Un(:,:,:)=reshape(Undata(j,:),n,n,n);
    Unt = fftn(Un);
    
    Unt_filter = Unt .* filter;
    Un_filter = ifftn(Unt_filter);
    [~, idx] = max(abs(Un_filter(:)));
    x = X_tmp(idx); y = Y_tmp(idx); z = Z_tmp(idx);
    X_record(j) = x; Y_record(j) = y; Z_record(j) = z;
end

figure(); plot3(X_record,Y_record,Z_record,'-o','Color','b','MarkerSize',10);
grid on
set(gca,'FontSize',15)
xlabel('X Direction/Unit length');
ylabel('Y Direction/Unit length');
zlabel('Z Direction/Unit length');
%%
clear all;close all; clc;
load Testdata
L=15; % spatial domain
n=64; % Fourier modes
x2=linspace(-L,L,n+1); x=x2(1:n); y=x; z=x;
k=(2*pi/(2*L))*[0:(n/2-1) -n/2:-1]; ks=fftshift(k);
[X,Y,Z]=meshgrid(x,y,z);
[Kx,Ky,Kz]=meshgrid(ks,ks,ks);
for j=1:1
Un(:,:,:)=reshape(Undata(j,:),n,n,n);
close all, isosurface(X,Y,Z,abs(Un),0.4)
axis([-20 20 -20 20 -20 20]),
xlabel('X Direction/Unit length');
ylabel('Y Direction/Unit length');
zlabel('Z Direction/Unit length');

title('Demo of ultrasound 3-d Data(with Volume value equal 0.4)');
grid on, drawnow

pause(1)
end