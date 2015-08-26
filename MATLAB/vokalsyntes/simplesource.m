function Y = simplesource(F0)
%
% sawtooth_source - variable frequency sawtooth waveform generator 
% input:
%   F0 (1xN row vector) - time-varying frequency (normalized by fs)

Ph = cumsum(F0);
Z = 2*mod(Ph,1.0)-1;
Y = diff(Z)<0;
Y(end+1)=0;
Y=double(Y);
