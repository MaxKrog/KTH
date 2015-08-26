clear; close all; clc

tic;
%% Read video

uPath = userpath;
file = strcat(uPath(1:end-1),'/testABCD.mp4'); 
newfile = strcat(uPath(1:end-1),'test.avi');
vidObj = VideoReader(file); % obj generation 
nFrames = 1; %vidObj.NumberOfFrames;
vidHeight = vidObj.Height;
vidWidth = vidObj.Width;

% Change vidScale to resize the video being processed
vidScale = 0.1;
width = vidWidth*vidScale;
height = vidHeight*vidScale;

% Preallocate movie structure.
mov(1:nFrames) = struct('cdata', zeros(height, width, 1, 'uint8'));
movDecoded(1:nFrames) = struct('cdata', zeros(height,width,1,'uint8'),...
    'colormap', []);

% Read one frame at a time. Convert to YUV. Extract BW frame. Create
% mov-struct
for k = 1 : nFrames
    frame = read(vidObj,k);
    frame = imresize(frame,vidScale);
    YUVframe = frameRGB2YUV(frame);
    BWframe = YUVframe(:,:,1);
    mov(k).cdata = BWframe;
    
end

% select a random frame from the video and create a huffman-codebook
randFrame = mov(randi([1,nFrames],1,1)).cdata;
randEncodedVector = diffEncoder(randFrame);
diffcodebook = huffmanCodebook(randEncodedVector);


%% huff-it
% had to change codebook to include both symbols and codewords. Also had to
% make it a fixed size with symbols ranging from -255 to 255 to make the
% codebook work for every different frame in the video. This really
% increases the decoding time for my huffmanDecode-function. 
% Faster to make new codebook every frame?

for k=1:nFrames
    disp('Frame: ');
    disp(k);
    encodedVector = diffEncoder(mov(k).cdata);
    huffEncDiffVec = huffmanEncoder(encodedVector, diffcodebook);
    huffDecDiffVec = huffmanDecoder(huffEncDiffVec, diffcodebook, width, height);
    decodedVector = diffDecoder(huffDecDiffVec, height, width);
    movDecoded(k).cdata = decodedVector;
end

if(isequal(mov.cdata,movDecoded.cdata))
    disp('Equal')
else
    disp('not equal')
end
figure, imshow(decodedVector);

writerObj = VideoWriter(newfile,movDecoded);
open(writerObj);

disp('Total conversion: ');
toc