%% 1. Select and show a random frame from your video
% You can also load a pre-stored grayscale frame in but it needs to maintain a good resolution!

patchDim = 8;
frame = imread('michelleBW.jpg');
[originalHeight, originalWidth] = size(frame);

%% 2. Segment the frame into image patches using patchImage function

[patches, height, width] = patchImage(frame, patchDim, patchDim);

%% 3. For each patch use [ matDCTCoeff ] = dctCoeffi( imagePatch  ) 
% to get the cosine square matrix and denote the patch using a vector of DCT
% coefficients.

baseVectorMatrix = dctCoeffi(patches(:,:,1));

for i = 1: length(patches)
    patch = reshape(patches(:,:,i), 1, []) - 128;             %Reshapes patch to a row.
    patchesEncoded(:,:,i) = patch * baseVectorMatrix';
end

%% 4. For each patch, reconstruct it using the first 16/32 coefficients

for i = 1: length(patches)
    patchRow = patchesEncoded(:,:,i);
    patchesDecoded(:,:,i) = reshape( patchRow * baseVectorMatrix, patchDim, patchDim) + 128;
end


%% 5. Reconstruct the frame and calculate the quality loss in Mean Squared Error 
% task 1. show the reconstructed frame using 16/32 coefficients
% respectively
% task 2. calculate loss

X = reshape(patchesDecoded, patchDim, []);
X = reshape( X, [ patchDim width height./patchDim ] ); 
X = permute( X, [ 1 3 2 ] );
X = reshape( X, [ height width ] );
X = uint8(X);

X = X(1:originalHeight, 1: originalWidth);       %Make sure X has same dimensions as frame.
disp('Mean squared error is:');
disp(meanSquaredError(frame, X));
imshow(X);


%% 6. Apply quantization to DCT coefficients and study the quanlity loss in Mean Squared Error
% task 1. reconstructed frame using quantized 16/32 coefficients
% respectively (command floor can be used for quantization)
% task 2. calculate loss

% We will quantize by setting only keeping the top-left value of every
% patch. This is also called the constant component and defines the
% constant hue of the patch.

patchesEncoded(1,2:end,:) = 0;

for i = 1: length(patches)
    patchRow = patchesEncoded(:,:,i);
    patchesDecoded(:,:,i) = reshape( patchRow * baseVectorMatrix, patchDim, patchDim) + 128;
end


X = reshape(patchesDecoded, patchDim, []);
X = reshape( X, [ patchDim width height./patchDim ] ); 
X = permute( X, [ 1 3 2 ] );
X = reshape( X, [ height width ] );
X = uint8(X);

[height, width] = size(frame);
X = X(1:height, 1:width);       %Make sure X has same dimensions as frame.
disp('Mean squared error is:');
disp(meanSquaredError(frame, X));
imshow(X);