% img = imread('../pset1/img1.jpg');


messi = imread('messi.jpg');
messi_size = size(messi);
% messi = double(imresize(messi, [256 NaN], 'bilinear'));
messi = double(messi);
messi_mean = mean(messi, 3);


maradona = imread('maradona.jpg');
maradona = double(imresize(maradona, messi_size(1:2), 'bilinear'));
maradona_mean = mean(maradona, 3);

% re-balance them so that they have the same average intensity
messi_mean = mean(maradona_mean(:))/mean(messi_mean(:)) * messi_mean;


numImages = 4;
fig = figure(1);
clf(fig);
subplot(numImages,1,1)
image(messi/255.0);

subplot(numImages,1,2)
image(maradona/255.0);


subplot(numImages,1,3)
imshow(messi_mean/255.0);

subplot(numImages,1,4)
imshow(maradona_mean/255.0);
% image(CVUtils.rescaleImageMatrix(highPassImg2, 0, 255.0)/255.0);


filterOrder = 250;
h = HybridImage(messi_mean, maradona_mean);
d = h.createHybridImage(filterOrder);

%%

fig = figure(2);
clf(fig);
imshow(d.normalizedHybridImage/255.0)