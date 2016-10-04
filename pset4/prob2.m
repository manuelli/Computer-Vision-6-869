img = imread('prob2.jpg');
img = double(img);

img_mean = mean(img,3);
height = 10
% height = 'auto'
[pyr, pind] = buildLpyr(img_mean, height);


fig = figure(1);
clf(fig);


showLpyr(pyr, pind);


% set the low pass residual (i.e the bottom level of the pyramid) to zero
meanIntensity = mean(img_mean(:));
pyr_copy = pyr;
numLevels = size(pind,1);
lowPassResidIdx = pyrBandIndices(pind, numLevels);


valToSet =  mean(pyr(lowPassResidIdx));
valToSet = 0;

pyr_copy(lowPassResidIdx) = valToSet;


recon = reconLpyr(pyr_copy, pind);
% rescale it
recon = recon - min(recon(:));


% squared error
delta = recon(:) - img_mean(:);

squaredError = norm(delta)


fig = figure(2);
clf(fig);
subplot(2,1,1);
imshow(img_mean/255.0);

subplot(2,1,2)
imshow(recon/255.0);

fig = figure(3);
clf(fig);

subplot(2,1,1)
F = fft2(img_mean);
F = fftshift(F);
vis = log(abs(F));
displayMin = min(vis(:));
displayMax = max(vis(:));

imshow(vis, [0,max(vis(:))]);
title('FFT: standard image');



subplot(2,1,2)
F2 = fft2(recon);
F2 = fftshift(F2);
vis2 = log(abs(F2));
imshow(vis2,[0,max(vis2(:))]);
title('FFT: No low pass residual');
