function [ matDCTCoeff ] = dctCoeffi( imagePatch  )
% Input imagePatch , an image patch
% Output matDCTCoeff, a N*N matrix of DCT coefficients

% Obviously, it is a completed function.
%% 
N = numel(imagePatch);
n = 0 : N-1;

wei = [ 1/sqrt(N), ones(1,N-1) * sqrt(2/N)];
matDCTCoeff = zeros(N);

for kPtr = 1: N
    k = kPtr -1;
    matDCTCoeff(kPtr,:) = cos(pi/N * (n+0.5)*k).* wei(kPtr);
end

end

