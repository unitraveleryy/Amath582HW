%% cropped face

% what we could do use ECON SVD
% reshape the mode in U to see the eigenfaces
% low rank approximation, how many modes are needed to make up 90% energy
% how much difference by comparing the norm(X-X_r)/norm(X)

% just one category face

% all categories 

% load data
rootdir = 'CroppedYale';
filelist = dir(fullfile(rootdir, '**\*.*'));  %get list of files and folders in any subfolder
filelist = filelist(~[filelist.isdir]);  %remove folders from list
numPic = length(filelist);
X = zeros(192*168,numPic);
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
avg = reshape(mn,192,168);
imshow(uint8(avg));
% plot singular values
figure();
plot(sig,'ro-');xlabel('singular value index');ylabel('singular value');
% plot mode
figure();
for ii = 1:9
    subplot(3,3,ii);
    mode = reshape(u(:,ii),192,168);
    imagesc(mode);
    axis ij; title(['PC',num2str(ii)])
end

%% cropped face reconstruction
numMode = [10 100 200 400 500];
for ll = 1:length(numMode)
    feature = numMode(ll);
    cord = u.';
    X_recon = (u(:,1:feature)*cord(1:feature,:))*X;
    error = norm(X_recon-X)/norm(X)
    figure();
    for pp = 1:12
        subplot(3,4,pp);
        imshow(uint8(reshape(X_recon(:,pp),192,168)));
    end
end
%% plot error decreasing
error = [13.16 2.88 1.56 0.78 0.62];
x = [10 100 200 400 500];
figure();plot(x,error,'ro-');xlabel('number of modes chosen to reconstruct the image');
ylabel('error rate percentage');
%% rename the file
mypath = 'yalefaces';
names = dir(mypath);
names([names.isdir]) = [];
fileNames = {names.name};
for iFile = 1: length(fileNames)  %# Loop over the file names
      oldName = fileNames{iFile};
      newName = [erase(oldName, '.') '.jpg'];  %# Make the new name
      f = fullfile(mypath, newName);
      g = fullfile(mypath, fileNames{iFile});
      movefile(g,f);        %# Rename the file
end