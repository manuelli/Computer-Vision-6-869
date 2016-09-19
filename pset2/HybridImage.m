classdef HybridImage

  properties
    imgA;
    imgB;
  end


  methods
    function obj = HybridImage(imgA, imgB)
      obj.imgA = imgA;
      obj.imgB = imgB;
    end


    function d = createHybridImage(obj,filterOrder)
      d = struct(); % just a place to store return data

      [lowPassB, highPassB] = BinomialGaussianFilter.blurImageSingleChannel(obj.imgB, filterOrder);
      [lowPassA, highPassA] = BinomialGaussianFilter.blurImageSingleChannel(obj.imgA, filterOrder);


      % combine the two images now
      hybridImage = lowPassB + highPassA;

      d.hybridImage = hybridImage;

      d.normalizedHybridImage = CVUtils.rescaleMatrix(hybridImage, 0, 255.01);
    end
  end

end