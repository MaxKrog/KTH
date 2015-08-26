function Y = formantfilter(F,BW,X)
% input:
%   F (1xN row vector) Frekvens-vektor (varierar)
%   BW (real number) Bandbredd
%   X (1xN row vector) Ljud att applicera filtret på.
% output:
%   Y (1xN row vector)  - Output sequence

utLjud = zeros(size(F));

alpha = F*2*pi;
R = (1 - BW/2);

b0 = 1-R.^2*sin(alpha);
a1 = -2*R*cos(alpha);
a2 =  R.^2;

utLjud(1) = b0(1)*X(1);
utLjud(2) = b0(2)*X(2) - a1(2)*utLjud(1);

for n = 3:1:length(F)
    utLjud(n) = b0(n)*X(n)-a1(n)*utLjud(n-1) - a2*utLjud(n-2);
end

Y = utLjud
