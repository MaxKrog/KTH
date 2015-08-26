function C = jpeg_encode(I)
%
% jpeg_encode - encode image I using block-by-block DCT coefficients
%
% input:
%  I (nxm matrix) - Input image
% output:
%  C (nxm matrix) 

I = I -128;
T = dct_basis(8);

[height, width] = size(I);

for q = 1 :8: floor(height/8)*8
    for p = 1 :8:floor(width/8)*8
        
        C(q:q+7,p:p+7) = T'*I(q:q+7,p:p+7)*T;
        
    end
end

