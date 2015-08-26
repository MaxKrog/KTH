imgBW = rgb2gray( imresize( imread('michelle.jpg'), 0.1) );

[freq,symbols] = imhist(imgBW);
P = freq./sum(freq);

imgBW = reshape(imgBW, 1, []);
huffmanDict = huffmandict(symbols, P);

encodedImg = huffmanenco(imgBW, huffmanDict);
decodedImg = huffmandeco(encodedImg, huffmanDict);