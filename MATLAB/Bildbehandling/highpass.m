
I = mean(double(imread('lynn-eyes-halftone.png')),3);

Isub = gaussblur(I,25);


Ifiltrad = I - Isub;


subplot(2,1,1), imshow(I,[])
subplot(2,1,2), imshow(Ifiltrad,[])