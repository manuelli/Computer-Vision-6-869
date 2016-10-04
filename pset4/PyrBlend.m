function res = PyrBlend(im1, im2, mask, filterType)

  % provide a default horizontal blend mask if one is not passed in
  if (nargin < 3)
    mask = 0*im1;
    halfCols = floor(size(mask,2)/2.0);
    mask(:,1:halfCols) = 1;
  end

  if (nargin < 4)
    filterType = 'binom5';
  end

  % use a custom filter
  % L = 5;
  % alphaVal = 2.0;
  % gaussFilter = gausswin(L, alphaVal);
  % gaussFilter = sqrt(2)*gaussFilter/sum(gaussFilter);
  
  % % filterType = 'binom20';

  % % filterType = 'binom30';
  % filterType = gaussFilter;

  % this will be a gaussian pyramid
  [pyr_mask, pind_mask] = buildGpyr(mask, 'auto', filterType);

  height = size(pind_mask,1)
  % construct Laplacian pyramids for each of the input images
  [pyr_1, pind_1] = buildLpyr(im1, height, filterType);
  [pyr_2, pind_2] = buildLpyr(im2, height, filterType);


  % now we need to just do dot product for each level of the pyramid and then do reconstruction

  pyr_blend = 0*pyr_1;

  numLevels = size(pind_mask, 1);
  for bandIdx=1:numLevels
    indices = pyrBandIndices(pind_1, bandIdx);

    maxVal = max(pyr_mask(indices));

    maskBand = pyr_mask(indices)/(1.0*maxVal);
    pyr_blend(indices) = maskBand.*pyr_1(indices) + (1-maskBand).*pyr_2(indices);
  end

  % now we just need to reconstruct the original
  res = reconLpyr(pyr_blend, pind_1);

end