function T = dct_basis(m)
%
% dct_basis - calculate basis vectors for DCT-transform
%
% input:
%   m (real number)  - Basis vector length
% output:
%   T = (mxm matrix) - DCT basis matrix where each column is a basis vector

T = zeros(m);

for p = 0:m-1
    q = 0;
    t = 1/sqrt(m);
    T(p+1,q+1) = t;
    
    for q = 1:m-1
        t = sqrt(2/m)*cos((pi*(2*p+1)*q)/(2*m));
        T(p+1,q+1) = t;
    end
end

