%% Differential encoding/decoding

% First we make a random 200 x 200 matrix.
frame = uint8(rand(200, 250) * 250);
[height, width] = size(frame);

% Then we encode it with differential-encoding
frameDiffEncoded = diffEncoder(frame);

% Then we decode it with differntial-decoding.
frameDiffDecoded = diffDecoder(frameDiffEncoded, height, width);

% And to prove that the encoding works without data loss:

if isequal(frame, frameDiffDecoded)
    disp('No data loss');
end