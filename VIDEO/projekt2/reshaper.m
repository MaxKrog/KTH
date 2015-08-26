function [ frame ] = reshaper( patches, height, width )


X = reshape(patches, 8, []);
X = reshape( X, [ 8 width height./8 ] ); 
X = permute( X, [ 1 3 2 ] );
X = reshape( X, [ height width ] );
frame = uint8(X);


end

