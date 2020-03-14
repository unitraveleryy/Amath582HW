%% for uncropped faces
% load data
rootdir = 'yalefaces';
filelist = dir(fullfile(rootdir, '**\*.*'));  %get list of files and folders in any subfolder
filelist = filelist(~[filelist.isdir]);  %remove folders from list
numPic = length(filelist);
X = zeros(243*320,numPic); %%%% image size
%%
% reshape image & store them in data Matrix X
for kk = 1:numPic
    data = filelist(kk).name;
    path = filelist(kk).folder;
    pic = imread([path '\' data]);
    X(:,kk) = double(pic(:));
end
% svd analysis
[m,n] = size(X);
mn = mean(X,2);
X = X - repmat(mn,1,n);

[u,s,v]=svd(X,'econ');
Y = u' * X;
sig = diag(s);

% plot avg face;
figure();
avg = reshape(mn,243,320); %%%% image size
imshow(uint8(avg));
% plot singular values
figure();
plot(sig,'ro-');xlabel('singular value index');ylabel('singular value');
% plot mode
figure();
for ii = 1:9
    subplot(3,3,ii);
    mode = reshape(u(:,ii),243,320); %%%% image size
    imagesc(mode);
    axis ij; title(['PC',num2str(ii)])
end
%% cropped face reconstruction
numMode = [10 20 40 80 120];
for ll = 1:length(numMode)
    feature = numMode(ll);
    cord = u.';
    temp = cord(1:feature,:)*X;
    X_recon = u(:,1:feature)*temp;
    error = norm(X_recon-X)/norm(X)
    figure();
    for pp = 1:12
        subplot(3,4,pp);
        imshow(uint8(reshape(X_recon(:,pp),243,320))); %%%% image size
        colormap gray; axis ij;
    end
end
%% plot error rate
error = [21 13.12 7.5 4.44 2.96];
x = [10 20 40 80 120];
figure();plot(x,error,'ro-');xlabel('number of modes chosen to reconstruct the image');
ylabel('error rate percentage');