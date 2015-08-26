function [Y] = statiskavokaler(f , bandbredd, ljud)

R = (1 - bandbredd/2);
alpha = 2*pi*f;

b = [ 1-R.^2*sin(alpha)];
a = [1, (-R*exp(1i*alpha) -R*exp(-1i*alpha)) , R.^2];

Y = filter(b,a,ljud);