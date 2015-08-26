m = 8

I = dct_basis(m);


ettor = eye(8);
C = I'*ettor*I;

for k=1: m^2
    tom = zeros(m);
    tom(k) = 1;
    invers = I*tom*I';
    subplot(m,m,k);
    imagesc(invers),
    title(k);
    
end