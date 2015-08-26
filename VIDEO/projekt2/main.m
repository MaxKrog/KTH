height = 80;
width = 80;
framesToRead = 3;
numberOfPatches = (height * width) / ( 8 * 8);

vidObj = VideoReader('video.mp4');
mov(1: framesToRead) = struct('data', zeros(height, width ));

for i = 1: framesToRead;
    frame = read(vidObj, i);
    frame = imresize(frame, [height width]);
    mov(i).data = rgb2gray(frame);  
end

encodedMov(1: framesToRead) = struct('patches', zeros(8, 8, numberOfPatches), 'motionVector', zeros(1, 2, numberOfPatches));

encodedMov(1).patches = patchImage(mov(1).data, 8);
encodedMov(1).patches = DCTEncode(encodedMov(1).patches);

reconstructedFrame = DCTDecode(encodedMov(1).patches);
reconstructedFrame = reshaper(reconstructedFrame, height, width);

for i = 2: 2
    imagePatches = patchImage(mov(i).data, 8);
    [m, vec] = blockMatching(imagePatches, reconstructedFrame);
end

