function [ imagePatches ] = patchImage( aBWFrame, patchDim )
%% Introduction of patchImage
% This function segments an input image/frame into a number of
% non-overlapping patches as the output.
%   
%   Input:
%   1. aBWFrame, is a black and white image or frame to be segmented
%   2. patchWidth and patchHeight define the width and height of the segmented image patches 
%   Output: 
%   imagePatches is a multi-dimiension matrix (a stack of segmented patches)
%   whose size == patchHeight * patchWidth * numPatch
%   numPatch is the total number of image patches can be segmented from aBWFrame by this function
%   Width/Height, dimensions of the the frame with padded zeros.
%
%This function padds zeros around the frame to not clip any data.

[height, width] = size(aBWFrame);
rows = ceil(height/patchDim);
columns = ceil(width/patchDim);

%Padd zeros:
aBWFrame(height: rows * patchDim, width:columns * patchDim) = 0;

placeholder = zeros(patchDim, patchDim, rows*columns);

index = 1;

for row = 1: rows
    rowEnd = row * patchDim;
    rowStart = rowEnd - patchDim + 1;
    
    for col = 1: columns
        columnEnd = col * patchDim;
        columnStart = columnEnd - patchDim +1;
        
        placeholder(:, :, index) = aBWFrame(rowStart:rowEnd, columnStart:columnEnd);
        
        index = index + 1;
        
    end
end

imagePatches = placeholder;

end

