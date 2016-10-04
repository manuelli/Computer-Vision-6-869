function returnData = setLowPassResidualToZero(img, numLevels)
	[pyr, pind] = buildLpyr(img, numLevels);
	lowPassResidIdx = pyrBandIndices(pind, numLevels);

	% set the low pass residual to zero
	valToSet = 0;
	pyr(lowPassResidIdx) = valToSet;

	recon = reconLpyr(pyr, pind);
	recon = recon - min(recon(:));


	returnData = struct();
	returnData.recon = recon;
	returnData.pyr = pyr;
	returnData.pind = pind;

	returnData.squaredError = norm(img(:) - recon(:));

end