% img = imread('../pset1/img1.jpg');

img = imread('sailboat.jpg');


messi = imread('messi.jpg')
messi = img = double(imresize(img, [256 NaN], 'bilinear'));
messi_mean = mean(messi, 3)



img = double(imresize(img, [256 NaN], 'bilinear'));
[nrows ncols colors] = size(img);

filterOrder = 1;
[blurredImg, highPassImg] = BinomialGaussianFilter.blurImage(img, filterOrder);




[lowPassImg2, highPassImg2] = BinomialGaussianFilter.blurImage(img, 30);

sharpenedImg = img + highPassImg;
sharpenedImg = CVUtils.rescaleImageMatrix(sharpenedImg, 0.0, 255.0);
%%


numImages = 4;
fig = figure(1);
clf(fig);
subplot(numImages,1,1)
image(img/255.0);

subplot(numImages,1,2);
image(blurredImg/255.0);

subplot(numImages,1,3);
image(sharpenedImg/255.01);


subplot(numImages,1,4);
image(lowPassImg2/255.0)
% image(CVUtils.rescaleImageMatrix(highPassImg2, 0, 255.0)/255.0);


%%
