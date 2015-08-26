function I = jpeg_decode(C)
%
% jpeg_decode - encode image I using block-by-block DCT coefficients
%
% input:
%  C (nxm matrix) - Input DCT coefficient matrix
% output:
%  I (nxm matrix) - Output image

dimensions = 8;
Cmatrix = [
16 11 10 16 24 40 51 61
12 12 14 19 26 58 60 55
14 13 16 24 40 57 69 56
14 17 22 29 51 87 80 62
18 22 37 56 68 109 103 77
24 35 55 64 81 104 113 92
49 64 78 87 103 121 120 101
72 92 95 98 112 100 103 99];

T = dct_basis(8);
[height, width] = size(C);

for q = 1 :dimensions: floor(height/dimensions)*dimensions
    for p = 1 :dimensions:floor(width/dimensions)*dimensions
        
        I(q:q+7,p:p+7) = T*C(q:q+7,p:p+7)*T';
        
    end
end
I = I + 128;