%% diffDecoder
% decodes the previously encoded image.

function [ decodedImg ] = diffDecoder( encodedVector, height, width )
%   encodedVector : nx1 vector with the image differential-encoded
%   columns : the amount of columns in the original image.
% ouput:
%   decodedImg: a NxR image decoded from the encodedVector.


% Reshape the vector into a matrix, so we can do column-wise operations.
encodedImg = reshape(encodedVector, height, width);
encodedImg = double(encodedImg);

decodedImg = zeros(height, width);   %Placeholder

for colIndex = 1: width               %Loop over all columns.
    
    if colIndex == 1                    %Reference value at the start of the rows, just insert it.
        decodedImg(:, 1) = encodedImg(:,1);
        
    else                                %Take the last value and add the difference between it and the next value.
        decodedImg(:, colIndex) = decodedImg(:, colIndex - 1) + encodedImg(:, colIndex);
        
    end
end

decodedImg = uint8(decodedImg);         %the encodedVector was type 'double' to support negative values.
end

