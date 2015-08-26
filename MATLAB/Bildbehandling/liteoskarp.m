I = mean(double(imread('lynn-eyes-halftone.png')),3);

filter = ones(3,3)/9;
Isub=conv2(I,filter,'same');

%imshow(I,[]);
subplot(1,2,1), imshow(I,[])
subplot(1,2,2), imshow(Isub,[])
