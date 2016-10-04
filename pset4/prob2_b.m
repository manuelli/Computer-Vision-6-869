img = imread('prob2.jpg');
img = double(img);

img_mean = mean(img,3);


heights = 5:10;

data = {};
squaredErrorArray = zeros(length(heights),1);

for i=1:length(heights)
	numLevels = heights(i)
	data{numLevels} = setLowPassResidualToZero(img_mean,numLevels);
	squaredErrorArray(i) = data{numLevels}.squaredError;
end

close all;
fig = figure(1);
clf(fig);
plot(heights, squaredErrorArray);
xlabel('num levels in Laplacian pyramid');
ylabel('sum of squared error')
title('Reconstruction error setting low pass residual to zero');


levelNum = 5;
fig = figure(2);
clf(fig);

subplot(1,3,1)
imshow(data{5}.recon/255.0);
title('height = 5')

subplot(1,3,2)
% clf(fig);
imshow(data{7}.recon/255.0);
title('height = 7')

subplot(1,3,3)
% clf(fig);
imshow(data{10}.recon/255.0);
title('height = 10')




