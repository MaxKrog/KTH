function RGBFrame = frameYUV2RGB( YUVFrame )

%% Instruction
% this function convers YUV frames back to RGB
% Input = YUV frame size == [H*W*3]
% For Question 5 in specification, the U and V you have received actually
% have only 25% of the size as Y. To mimic such, you can either resize your U and
% V channels inside this funcion or use other methods as you want.

% Output = RGB frame size == [H*W*3]

Y = YUVFrame(:,:,1);
U = YUVFrame(:,:,2);
V = YUVFrame(:,:,3);

%Constants from lectures.
R = Y + 1.140 * V;
G = Y - 0.395 * U - 0.581 * V;
B = Y + 2.032 * U;

RGBFrame = cat(3, R, G, B);
RGBFrame = uint8(RGBFrame); %Back to original type.
end

