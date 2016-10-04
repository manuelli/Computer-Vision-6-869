img = imread('prob2.jpg');
img = double(img);

orange = imread('orangeHighRes.jpg');
orange = double(orange);

apple = imread('appleHighRes.jpg');
apple = double(apple);

orange_size = size(orange);

% resize apple to be same size as orange
apple = double(imresize(apple, orange_size(1:2), 'bilinear'));

% do everything in grey scale
apple_mean = mean(apple,3);
orange_mean = mean(orange, 3);


orange_mean = orange_mean*mean(apple_mean(:))/mean(orange_mean(:));

L = 50;
alpha = 1.0;
gaussFilter = gausswin(L, alpha);
gaussFilter = sqrt(2)* gaussFilter/sum(gaussFilter);

filterType = gaussFilter;
% filterType = 'binom5';

[pyr_1, pind_1] = buildLpyr(apple_mean, 'auto', filterType);
[pyr_2, pind_2] = buildLpyr(orange_mean, 'auto', filterType);


mask = 0*apple_mean;
halfCols = floor(size(mask,2)/2.0);
mask(:,1:halfCols) = 1;


binomFilter = namedFilter('binom10');

[pyr_mask, pind_mask] = buildGpyr(mask,'auto', gaussFilter);
maskBand = pyrBand(pyr_mask, pind_mask, 2);
size(pind_mask)
% reconstruct img1 from pyramid
recon_1 = reconLpyr(pyr_1,pind_1);

blendResult = PyrBlend(apple_mean, orange_mean, mask, filterType);


%% Plotting

fig = figure(1);
clf(fig);
showLpyr(pyr_1, pind_1);

% res = pyrBand(pyr, pind, 1);

fig = figure(2);
clf(fig);
imshow(blendResult/255.0);
% 
% fig = figure(3);
% clf(fig);
% imshow(orange_mean/255.0);


fig = figure(4);
clf(fig);
imshow(maskBand);


%% Gaussian window thing

fig = figure(5);
clf(fig);
hold on;
grid = 1:length(gaussFilter);
plot(gaussFilter','r');
plot(binomFilter', 'b');
hold off;