
img = imread('kellogs.jpg');
imgBW = rgb2gray(img);
[height, width] = size(imgBW);

codeBook = huffmanCodebook(imgBW);

binaryVector = huffmanEncoder(imgBW, codeBook);

decodedImage = huffmanDecoder(binaryVector, codeBook, 50, 50);


