myPic = imread('michelle.jpg');
YUVPic = frameRGB2YUV(myPic);
YPic = YUVPic(:,:,1);
imshow(YPic);

counts = imhist(YPic);
p = counts/numel(YPic);

for i = 1:256;
    codewords{i} = [];
    probabilities{i} = p(i);
    pixelValues{i} = i;
end

while (length(pixelValues) > 1);
    [sortedProb,indices] = sort(p);
    %sortedProb = probability of that value
    %indices = value at same index as the probability in sortedProb
    
    pixelValues0 = pixelValues{indices(1)};
    pixelValues1 = pixelValues{indices(2)};
    % Combining together pixelvalues0 & pixelvalues1 into one.
    pixelValues{length(pixelValues)+1} = [pixelValues0, pixelValues1];
    % We have to give the new set the corresponding probability
    p(length(p)+1) = sum(sortedProb(1:2));
    
    for i = 1:length(pixelValues0);
        codewords{pixelValues0(i)} = [codewords{pixelValues0(i)}, 0];
        % Putting 0 on to the new pixel value that's suppose to have it.
    end
    
    for i = 1:length(pixelValues1);
        codewords{pixelValues1(i)} = [codewords{pixelValues1(i)}, 1];
    end
    pixelValues(indices(1:2)) = [];
    % Removes the lowest sets(pixel values) with the lowest probability
    p(indices(1:2)) = []; %Removes probabilities
end
for i = 1:length(codewords);
    codewords {i} = fliplr(codewords{i});
end
CodeBook = codewords;