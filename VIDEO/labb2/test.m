imgBW = rgb2gray( imresize( imread('michelle.jpg'), 0.1) );
[height, width] = size(imgBW);
codeBook = huffmanCodebook(imgBW, 0, 256);

imgHuffmanEncoded = huffmanEncoder(imgBW, codeBook);

imgHuffmanDecoded = huffmanDecoder(imgHuffmanEncoded, codeBook, height, width);