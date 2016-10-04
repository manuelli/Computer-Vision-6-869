function returnData = setLowPassResidualToZero(img, numLevels, filterType)
	if (nargin < 3)
		filterType = 'binom5';
	end

	[pyr, pind] = buildLpyr(img, numLevels, filterType);
	lowPassResidIdx = pyrBandIndices(pind, numLevels);

	% set the low pass residual to zero
	valToSet = 0.0;
	% valToSet = mean(img(:));
	% valToSet = mean(pyr(lowPassResidIdx))
	pyr(lowPassResidIdx) = valToSet;

	recon = reconLpyr(pyr, pind);

	returnData = struct();
	meanRecon = mean(recon(:))
	maxRecon = max(recon(:))
	minRecon = min(recon(:))

	returnData.reconRaw = recon;

	% rescale it to fit on 0,255.0
	recon = recon - min(recon(:));
	recon = recon/max(recon(:))*255.0;


	
	returnData.recon = recon;

	returnData.pyr = pyr;
	returnData.pind = pind;

	returnData.squaredError = norm(img(:) - recon(:));

end