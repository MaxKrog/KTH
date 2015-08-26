% input:
%   F (1xN row vector) Frekvens-vektor (varierar)
%   BW (real number) Bandbredd
%   X (1xN row vector) Ljud att applicera filtret på.
% output:
%   Y (1xN row vector)  - Output sequence
clear;
F = ones(1,8000) * 2.5;
%X = rand((size(F)));
X = [1 zeros(1, length(F)-1)];
utljud = zeros(size(F));

BW = 0.005;

alpha = F*2*pi;
R = (1 - BW/2);

b0 = 1-R.^2*sin(alpha);
a1 = -2*R*cos(alpha);
a2 =  R.^2;

utljud(1) = b0(1)*X(1);
utljud(2) = b0(2)*X(2) - a1(2)*utljud(1);

for n = 3:1:length(F)
    utljud(n) = b0(n)*X(n)-a1(n)*utljud(n-1) - a2*utljud(n-2);
end

utljud = utljud/max(utljud);
sound(utljud);
