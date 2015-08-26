function [ motionVector, blockDifference ] = blockMatching( patches, referenceImage )
%% Instruction (cross refer to specification of Project 2)
% This function calculates the motion vector and the difference of  
% certain block in a future frame with respect of the reference frame (referenceImage)

% Input:
% imageBlock: black and white image patch separated from a frame
% referenceImage: the image/frame used as the reference to calculate the motion
% vector and the difference matrix

% Output:
% motionVector == a vector conatins offset value in vertical and horizontal
% directions that tells the receiver where to find its best matching from
% the referenceImage

% blockDifference == a matrix whose size euquals to imageBlock, in which each
% elements equals to imageBlock minus the best matching of imageBlock in referenceImage.

% You can add input/output arguments if necessary, e.g. the index of the imageBlock.

% Realizing the functionality of searching the best matching for
% image blocks in a reference frame can be implement here in terms of subfunction or in a separate .m file
%%

for i = 1: 1 %length(patches(1,1,:))

    imshow(referenceImage(10:28,30:48));
end

motionVector = 0;
blockDifference = 0;


end

