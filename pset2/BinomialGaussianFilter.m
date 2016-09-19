classdef BinomialGaussianFilter

  properties(Constant)
    b0 = [1,1];
  end

  methods(Static)

    % computes the nth order binomial kernel
    function [kernel, returnData] = getKernel(filterOrder)
      returnData = struct();

      returnData.filterOrder = filterOrder;
      b0 = BinomialGaussianFilter.b0;
      one_dim_kernel = b0;
      for i=1:filterOrder
        one_dim_kernel = conv(one_dim_kernel, b0);
      end

      kernel = conv2(one_dim_kernel, one_dim_kernel');
      kernel = kernel/(1.0*sum(kernel(:))); % normalize the kernel
      returnData.sigma = filterOrder/4.0;

    end

    % apply kernel to a single color channel
    function [lowPassImg, highPassImg, returnData] = blurImageSingleChannel(rawImage, filterOrder)
      [kernel, returnData] = BinomialGaussianFilter.getKernel(filterOrder);
      lowPassImg = conv2(rawImage, kernel, 'same');
      highPassImg = rawImage - lowPassImg;
    end


    % apply kernel to each color channel then re-assemble.
    function [lowPassImg, highPassImg, returnData] = blurImage(rawImage, filterOrder)

      lowPassImg = 0*rawImage;
      highPassImg = 0*rawImage;

      for colorChannel=1:3
        [lowPassImgSingleChannel, highPassImgSingleChannel, returnData] = BinomialGaussianFilter.blurImageSingleChannel(rawImage(:,:,colorChannel), filterOrder);

        lowPassImg(:,:,colorChannel) = lowPassImgSingleChannel;
        highPassImg(:,:,colorChannel) = highPassImgSingleChannel;
      end
    end

    function M = clip(M, minVal, maxVal)
      M = min(M, maxVal);
      M = max(M, minVal);
    end

  end


end