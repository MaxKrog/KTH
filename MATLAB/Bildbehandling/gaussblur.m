function J=gaussblur(I,n)
% blur an image using a gaussian kernel
%
% input:
%   I (matrix) - image to be blurred
%   n (integer) - desired size of the gaussian kernel
% output:
%   J (matrix) - blurred image

sigma = n/6;
H = zeros(n,n);

X = [-(n-1)/2:(n-1)/2];
Y = [-(n-1)/2:(n-1)/2];
[X,Y] = meshgrid(X,Y);

H = exp(-(X.^2 + Y.^2)/(2*sigma.^2));
H = H/sum(sum(H));

J = conv2(I,H,'same');

end