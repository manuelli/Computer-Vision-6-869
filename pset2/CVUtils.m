classdef CVUtils

  methods(Static)
    function M = clip(M, minVal, maxVal)
      M = min(M, maxVal);
      M = max(M, minVal);
    end

    function rescaledImg = rescaleImageMatrix(rawImage, minVal, maxVal)
      rescaledImg = rawImage*0;

      for colorChannel=1:3
        rescaledImg(:,:,colorChannel) = CVUtils.rescaleMatrix(rawImage(:,:,colorChannel), minVal, maxVal);
      end
    end

    function M = rescaleMatrix(rawMatrix, minVal, maxVal)
      rawMin = min(rawMatrix(:));
      temp = rawMatrix - rawMin + minVal;

      maxTemp = max(temp(:));

      rescaleVal = max(maxTemp/maxVal, 1.0);

      M = temp/rescaleVal;
    end
  end

end