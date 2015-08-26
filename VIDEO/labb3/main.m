%% Video Technology Labb 3
% This report shows how to implement differential-encoding and top it with
% huffman-coding in matlab.

%%Reads a video and imports it into the "mov" variable.
vidObj = VideoReader('video.mp4');
width = 10;
height = 10;
framesToRead = 3; %vidObj.NumberOfFrames;

movBW(1: framesToRead) = struct('data', zeros(height, width ));
movDiffEncoded(1: framesToRead) = struct('data', zeros( height * width , 1, 'double'));
movDiffDecoded(1: framesToRead) = struct('data', zeros( height * width , 'uint8'));

%Read every frame and convert to BW in same procedure. Add to movBW-struct.
for i = 1: framesToRead
    frame = read(vidObj, i);
    frame = imresize(frame, [height width]);
    
    frameYUV = frameRGB2YUV(frame);
    frameBW = frameYUV(:,:,1);      %The Black and White frame.
    movBW(i).data = frameBW; 
    
end

%% Entropy before diff-encoding
disp(entropy(movBW(1).data));
disp(entropy(movBW(framesToRead).data));

for i = 1: framesToRead    %Diff-encoding
    movDiffEncoded(i).data = diffEncoder(movBW(i).data);
end

%% Entropy after differential-encoding
disp(entropy(movDiffEncoded(1).data));
disp(entropy(movDiffEncoded(framesToRead).data));

% Now we create a huffman-codebook
codebook = huffmanCodebook(movDiffEncoded(1).data);

%And then encode the allready diff-encoded movie with huffman aswell.
for i = 1: framesToRead
    movDiffHuffman{i} = huffmanEncoder(movDiffEncoded(i).data, codebook);
end

%and then decode it
for i = 1: framesToRead
    movDiffEncoded(i).data = huffmanDecoder(movDiffHuffman{i}, codebook, height, width);
end

for i = 1: framesToRead %And diff-decode
    movDecoded(i).data = diffDecoder(movDiffEncoded(i).data, width);
end

if isequal(movBW, movDecoded)
    disp('Theyre equal');
else
    disp('Theyre not equal');
end



