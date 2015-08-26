function J = blockproc(I)
%
% sample code to process an image in blocks of fixed size
% I is input image, J is output image
% In the inner loop, Isub and Jsub are 8x8 sub-images (input and output)
%
% Dimensinons of J will be rounded down to closest multiple of the
% blocksize, which means that the final dimensions of J can be 
% smaller than I!
%
% RENAME this function to something suitable and fill in processing code

blocksize = 8;
[height width] = size(I)

for bx = 0 : floor(width/blocksize)-1
  for by = 0 : floor(height/blocksize)-1
    xi = 1+bx*blocksize : (bx+1)*blocksize;
    yi = 1+by*blocksize : (by+1)*blocksize;
    Isub = I(yi,xi);

    % Isub is a 8x8 sub-image/matrix
 
    % **** put code below to do things to sub-images ****
    
 
    
    % for now, simply copy input to output
    Jsub = Isub;

    
    
    % **** end of code to process sub-images ****
    J(yi,xi) = Jsub;
  end
end
