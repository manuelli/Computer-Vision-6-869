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
% d = h.createHybridImage(filterOrder);

%%

filterOrderArray = [50,100,250,500];
filterOrderArray = [25,250,500];
% filterOrderArray = [25,50];

figCounter = 2;

fig = figure(2)
numFilters = numel(filterOrderArray);

for i=1:numel(filterOrderArray)
  fig = figure(i);
  clf(fig);
  % subplot(numFilters,1,i);
  filterOrder = filterOrderArray(i);
  d = h.createHybridImage(filterOrder);
  sigmaVal = filterOrder/4.0;
  imshow(d.clippedHybridImage/255.0)
  title(strcat('sigma = ',num2str(sigmaVal)));
end


% fig = figure(2);
% clf(fig);
% imshow(d.normalizedHybridImage/255.0)

% fig = figure(3);
% clf(fig);
% imshow(d.clippedHybridImage/255.0)