I = mean(double(imread('blomma.tif')),3);
%I = blockproc(I);%Formatteras till multiplar om 8 i höjd/längd-led

C = jpeg_encode(I);
UC = jpeg_decode(C);

colormap(gray);
subplot(1,3,1);
imagesc(I);
subplot(1,3,2);
imagesc(C);
subplot(1,3,3);
imagesc(UC);
