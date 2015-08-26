function YUVFrame  = frameRGB2YUV( RGBFrame )

%% Instruction
% this function simply transforms a RGBframe to its corresponding YUVframe
% input
% RGBframe, size == [frameHeight * framewidth * 3]

% output
% YUVframe, size == [frameHeight * framewidth * 3]
% For Question 5 in specification, U and V should have only 25% size of Y

%% Now you are on your own... 
R = RGBFrame(:,:,1);
G = RGBFrame(:,:,2);
B = RGBFrame(:,:,3);

%Constans from lectures.
Y = 0.299 * R + 0.587 * G + 0.114*B; 
U = 0.492 * (B-Y);
V = 0.877 * (R-Y);

YUVFrame = cat(3, Y, U, V);

end

