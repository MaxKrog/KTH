img = imread('bild.jpg');
img = imresize(img, 0.2);
frameYUV = frameRGB2YUV(img);
frameRGB = frameYUV2RGB(frameYUV);