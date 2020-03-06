cam1 = importdata('cam1_1.mat');
cam2 = importdata('cam2_1.mat');
cam3 = importdata('cam3_1.mat');

u = [0.5452   -0.3158   -0.2118    0.7398   -0.0034   -0.1039;
    0.0038   -0.3060    0.0716   -0.1097   -0.9415    0.0527;
    0.6809    0.2385    0.6599   -0.2043    0.0019    0.0480;
   -0.0185   -0.8040    0.2381   -0.3075    0.2962   -0.3381;
    0.0682    0.3173   -0.1443   -0.0857   -0.1552   -0.9178;
    0.4839   -0.0528   -0.6611   -0.5449    0.0416    0.1655];

aver_cam1 = zeros(size(cam1,1),size(cam1,2),size(cam1,3));
aver_cam2 = zeros(size(cam2,1),size(cam2,2),size(cam2,3));
aver_cam3 = zeros(size(cam3,1),size(cam3,2),size(cam3,3));

figure();
for kk = 1:size(cam2,4)
    aver_cam1 = aver_cam1 + double(cam2(:,:,:,kk));
end
aver_cam1 = floor(aver_cam1)/size(cam2,4);
imshow(aver_cam1);

%%


%%
figure(); 

for ii = 101:size(cam2,4)
    frame = cam1(:,:,:,ii);
    frame = rgb2gray(frame);
    imshow(frame);
    objectRegion = round(getPosition(imrect));
    objectImage = insertShape(frame,'Rectangle',objectRegion,'Color','red');
    figure();imshow(objectImage);
    dataAnaly = frame(objectRegion(2):(objectRegion(2)+objectRegion(4)),...
                      objectRegion(1):(objectRegion(1)+objectRegion(3)));
    [~,I] = max(dataAnaly(:));
    [r,c] = ind2sub(size(dataAnaly),I)
    r = r + objectRegion(2)
    c = c + objectRegion(1)
    figure();
    pointImage = insertMarker(frame,[c r],'+','Color','green');
    imshow(pointImage);
    return
    
    [~,I] = max(dataAnaly(:));
    [r,c] = ind2sub(size(dataAnaly),I);
    pointImage = insertMarker(frame,[r c],'+','Color','green');
    imshow(pointImage);
    return
    imshow(frame);
    pause(0.05);
end
%%
figure();
xy_cam1 = zeros(2,size(cam1,4));%
for ii = 1:size(cam1,4)%
    frame = cam1(:,:,:,ii);
    frame = rgb2gray(frame);
    imshow(frame);
    objectRegion = round(getPosition(imrect));
    objectImage = insertShape(frame,'Rectangle',objectRegion,'Color','red');
    imshow(objectImage);
    pause(0.5)
    dataAnaly = frame(objectRegion(2):(objectRegion(2)+objectRegion(4)),...
                      objectRegion(1):(objectRegion(1)+objectRegion(3)));
    [~,I] = max(dataAnaly(:));
    [r,c] = ind2sub(size(dataAnaly),I)
    r = r + objectRegion(2)
    c = c + objectRegion(1)
    
    xy_cam1(:,ii) = [r;c];%
    
    pointImage = insertMarker(objectImage,[c r],'+','Color','green');
    imshow(pointImage);
    
    pause(0.5);
    ii
end

xy_cam2 = zeros(2,size(cam2,4));%
for ii = 1:size(cam2,4)%
    frame = cam2(:,:,:,ii);%
    frame = rgb2gray(frame);
    imshow(frame);
    objectRegion = round(getPosition(imrect));
    objectImage = insertShape(frame,'Rectangle',objectRegion,'Color','red');
    imshow(objectImage);
    pause(0.5)
    dataAnaly = frame(objectRegion(2):(objectRegion(2)+objectRegion(4)),...
                      objectRegion(1):(objectRegion(1)+objectRegion(3)));
    [~,I] = max(dataAnaly(:));
    [r,c] = ind2sub(size(dataAnaly),I)
    r = r + objectRegion(2)
    c = c + objectRegion(1)
    
    xy_cam2(:,ii) = [r;c];%
    
    pointImage = insertMarker(objectImage,[c r],'+','Color','green');
    imshow(pointImage);
    pause(0.5)
    ii
end

xy_cam3 = zeros(2,size(cam3,4));%
for ii = 1:size(cam3,4)%
    frame = cam3(:,:,:,ii);%
    frame = rgb2gray(frame);
    imshow(frame);
    objectRegion = round(getPosition(imrect));
    objectImage = insertShape(frame,'Rectangle',objectRegion,'Color','red');
    imshow(objectImage);
    pause(0.5)
    dataAnaly = frame(objectRegion(2):(objectRegion(2)+objectRegion(4)),...
                      objectRegion(1):(objectRegion(1)+objectRegion(3)));
    [~,I] = max(dataAnaly(:));
    [r,c] = ind2sub(size(dataAnaly),I)
    r = r + objectRegion(2)
    c = c + objectRegion(1)
    
    xy_cam3(:,ii) = [r;c];%
    
    pointImage = insertMarker(objectImage,[c r],'+','Color','green');
    imshow(pointImage);
    pause(0.5)
    ii
end
%%
clear all; close all; clc;
cam1 = importdata('cam1_4.mat');
cam2 = importdata('cam2_4.mat');
cam3 = importdata('cam3_4.mat');

frame = cam2(:,:,:,1);

figure();imshow(frame);
objectRegion = round(getPosition(imrect));


return

objectImage = insertShape(frame,'Rectangle',objectRegion,'Color','red');
figure();imshow(objectImage);

points = detectMinEigenFeatures(rgb2gray(frame),'ROI',objectRegion);

pointImage = insertMarker(frame,points.Location,'+','Color','white');
figure();
imshow(pointImage);

tracker = vision.PointTracker('MaxBidirectionalError',1);
initialize(tracker,points.Location,frame);

figure();
dim = size(cam2);%
frameCurr = cam2(:,:,:,1);%
[points, validity] = tracker(frameCurr);
dataPoints = zeros(size(points,1),size(points,2),dim(4)-1);
dataValidity = zeros(length(validity),dim(4)-1);
dataPoints(:,:,1) = points;
dataValidity(:,1) = validity;  

for ii = 2:dim(4)
    frameCurr = cam2(:,:,:,ii);%
    [points, validity] = tracker(frameCurr);
    dataPoints(:,:,ii) = points;
    dataValidity(:,ii) = validity;
    out = insertMarker(frameCurr,points(validity,:),'+');
    imshow(out);
    pause(0.1);
end
%%
clear all; close all; clc;
cam1 = importdata('cam1_4.mat');
cam2 = importdata('cam2_4.mat');
cam3 = importdata('cam3_4.mat');

xy_cam1 = zeros(2,size(cam1,4));
xy_cam2 = zeros(2,size(cam2,4));
xy_cam3 = zeros(2,size(cam3,4));

for ii = 1:length(xy_cam1)
    frame = cam1(:,:,:,ii);
    figure(1);imshow(frame);
    pos = ginput(1);
    xy_cam1(:,ii) = [pos(1);
                     pos(2)];
end
for ii = 1:length(xy_cam2)
    frame = cam2(:,:,:,ii);
    figure(1);imshow(frame);
    pos = ginput(1);
    xy_cam2(:,ii) = [pos(1);
                     pos(2)];
end
for ii = 1:length(xy_cam3)
    frame = cam3(:,:,:,ii);
    figure(1);imshow(frame);
    pos = ginput(1);
    xy_cam3(:,ii) = [pos(1);
                     pos(2)];
end
%%
save('pos_rec/xy_cam1_3.mat','xy_cam1');
save('pos_rec/xy_cam2_3.mat','xy_cam2');
save('pos_rec/xy_cam3_3.mat','xy_cam3');
%%
figure();

corrupt = [121 122 138 139 195 196 197 198 199 217 218];
corrupt = [];
for i = 1:size(corrupt,2)%
    ii = corrupt(i);
    frame = cam1(:,:,:,ii);
    frame = rgb2gray(frame);
    imshow(frame);
    objectRegion = round(getPosition(imrect));
    objectImage = insertShape(frame,'Rectangle',objectRegion,'Color','red');
    imshow(objectImage);
    pause(0.5)
    dataAnaly = frame(objectRegion(2):(objectRegion(2)+objectRegion(4)),...
                      objectRegion(1):(objectRegion(1)+objectRegion(3)));
    [~,I] = max(dataAnaly(:));
    [r,c] = ind2sub(size(dataAnaly),I)
    r = r + objectRegion(2)
    c = c + objectRegion(1)
    
    xy_cam1(:,ii) = [r;c];%
    
    pointImage = insertMarker(objectImage,[c r],'+','Color','green');
    imshow(pointImage);
    
    pause(0.5);
    ii
end
corrupt = [191 192 193 194 195 196 197 198 199 200 209 210 213 214 215 216 217 221 226 ...
           228 229 232 241 242 245 253 258 261 262 263 271 277];
       corrupt = [194 214 232 245 253 262 271];
       corrupt = [262];
for i = 1:size(corrupt,2)%
    ii = corrupt(i);
    frame = cam2(:,:,:,ii);%
    frame = rgb2gray(frame);
    imshow(frame);
    objectRegion = round(getPosition(imrect));
    objectImage = insertShape(frame,'Rectangle',objectRegion,'Color','red');
    imshow(objectImage);
    pause(0.5)
    dataAnaly = frame(objectRegion(2):(objectRegion(2)+objectRegion(4)),...
                      objectRegion(1):(objectRegion(1)+objectRegion(3)));
    [~,I] = max(dataAnaly(:));
    [r,c] = ind2sub(size(dataAnaly),I)
    r = r + objectRegion(2)
    c = c + objectRegion(1)
    
    xy_cam2(:,ii) = [r;c];%
    
    pointImage = insertMarker(objectImage,[c r],'+','Color','green');
    imshow(pointImage);
    pause(0.5)
    ii
end


corrupt = [181];
corrupt = [];
for i = 1:size(corrupt,2)%
    ii = corrupt(i);
    frame = cam3(:,:,:,ii);%
    frame = rgb2gray(frame);
    imshow(frame);
    objectRegion = round(getPosition(imrect));
    objectImage = insertShape(frame,'Rectangle',objectRegion,'Color','red');
    imshow(objectImage);
    pause(0.5)
    dataAnaly = frame(objectRegion(2):(objectRegion(2)+objectRegion(4)),...
                      objectRegion(1):(objectRegion(1)+objectRegion(3)));
    [~,I] = max(dataAnaly(:));
    [r,c] = ind2sub(size(dataAnaly),I)
    r = r + objectRegion(2)
    c = c + objectRegion(1)
    
    xy_cam3(:,ii) = [r;c];%
    
    pointImage = insertMarker(objectImage,[c r],'+','Color','green');
    imshow(pointImage);
    pause(0.5)
    ii
end