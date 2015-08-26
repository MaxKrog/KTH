function [ encodedVector ] = diffEncoder( imgBW ) 
%% diffEncoder
% This function encodes a black and white image into a single vector using
% differential coding
% Input: 
%   BWImg: black and white image i.e. a Y frame
%
% Output:
%   encodedVector: the BWImg encoded into a single vector through
%       differential-encoding.


[height, width] = size(imgBW);       % We need to know how many columns there is.
encodedImg = zeros(height, width);   % Placeholder for the encoded-img.

imgBW = double(imgBW);                  %Original type is uin8. uin8 cant be negative numbers (only 0-255) , which we need for diff-encoding.
    
for colIndex = 1: width               %For every column..
    
    if colIndex == 1                    %If first column, save as reference-value (don't change it)
        encodedImg(:, 1) = imgBW(:,1);
        
    else                                %Calculate difference between indexed column and the column before it.
        encodedImg(:, colIndex) = imgBW(:, colIndex) - imgBW(:, colIndex - 1);
        
    end
end

encodedVector = reshape(encodedImg, 1, []); %Reshape the matrix C x R into a single vector.

