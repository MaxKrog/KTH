I = mean(double(imread('teracotta-wall.jpg')),3);

a = [-1, -2, -1]';
b = [0, 0, 0]';
c = [1, 2, 1]';

Hx = [a,b,c];
Hy = Hx';

Gx = conv2(I,Hx);
Gy = conv2(I,Hy);
G = sqrt((Gx.^2+(Gy.^2)));


subplot(2,2,3),imshow(G,[]),title('G');
subplot(2,2,1), imshow(Gx,[]),title('X-led');
subplot(2,2,2), imshow(Gy,[]),title('Y-led');
