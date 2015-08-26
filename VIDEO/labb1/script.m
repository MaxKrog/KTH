clear; close all; clc

%% Define the path (modify it in case Matlab cannot find your file)

%pwd = current file location in filesystem.
file = strcat(pwd, '/testABCD.mp4');

%% Read and generate a move to display (you don't have to change this part)
vidObj = VideoReader(file); % obj generation 
nFrames = 1; % vidObj.NumberOfFrames;
vidHeight = vidObj.Height;
vidWidth = vidObj.Width;

% Preallocate movie structure.
mov(1:nFrames) = struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'), 'colormap', []);

% Read one frame at a time.
for k = 1 : nFrames
    mov(k).cdata = read(vidObj, k);
end

%% generate a figure based on the video's width and height.(no change need to be made as well)

hf = figure('position', [150 150 vidWidth vidHeight]);

%% Play back the movie once at the video's frame rate. (you can comment it if you want)
%movie(hf, mov, 1, vidObj.FrameRate);

%% Have a look at the RGB frame
% select a random frame from the video
%aRGBFrame =  mov(randi([1, nFrames],1,1)).cdata ;
aRGBFrame = imread('bild.jpg');
aRGBFrame = im2double(aRGBFrame); %Prevents clipping in the conversion-functions.

% extract each channel and show them (you work it out from here)

chaR = aRGBFrame(:,:,1);
chaG = aRGBFrame(:,:,2);
chaB = aRGBFrame(:,:,3);

% 
figure, 
subplot(1,3,1), imshow(chaR, []), title('R');
subplot(1,3,2), imshow(chaG, []), title('G') ;
subplot(1,3,3), imshow(chaB, []), title('B');

%% Call RGB to YUV functon 

YUVFrame = frameRGB2YUV(aRGBFrame); 

YFrame = YUVFrame(:,:,1);
UFrame = YUVFrame(:,:,2);
VFrame = YUVFrame(:,:,3);

% extract each channel in YUV frame and show
figure, 
subplot(1,3,1),imshow(YFrame, []),title('Y');
subplot(1,3,2),imshow(UFrame, []),title('U');
subplot(1,3,3),imshow(VFrame, []),title('V');


% Compare Color Frame to its grayscale frame
figure,
subplot(1,2,1), imshow(aRGBFrame,[]), title('Color');
subplot(1,2,2), imshow(YFrame,[]), title('BW');

%% Convert YUV back to RGB

% call the function frameYUV2RGB and show your results
backToRGBFrame = frameYUV2RGB(YUVFrame);

figure,
subplot(1,2,1), imshow(aRGBFrame, []), title('RGB');
subplot(1,2,2), imshow(backToRGBFrame, []), title('RGB -> YUV -> RGB');

