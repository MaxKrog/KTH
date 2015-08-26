imgBW = rgb2gray( imresize( imread('michelle.jpg'), 0.1) );
[height, width] = size(imgBW);

imgDiffEncoded = diffEncoder(imgBW);
imgDiffDecodeed = diffDecoder(imgDiffEncoded, height, width);
