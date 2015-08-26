%% huffmanCodebook
function [ CodeBook ] = huffmanCodebook( imgBW, min, max )

% This function generates Huffman dictionary (aka codebook) from a BW image
% Input: imgBW, which is a black and white image (UINT8). min/max, which is
% the min and max value of pixel intensity.
% Output: CodeBook, which is a 'table' for converting 256 grayscale levels to
% the corresponding codewords
% Note: Some of the codewords might be 'null' due to the absence of certain pixel intensities.
% You can add the input/output arguments if needed.

%% 
% *Entropy and probability distribution*
[height,width] = size(imgBW);
if (width>1)
    imgBW = reshape(imgBW, [1,(height*width)]);
end

[freq,symbols] = histcounts(imgBW, min:max);
symbols(end) = [];

P = freq./sum(freq);

%% 
% *Create codebook*

tempbook = cell(length(symbols),2); % List of codewords, same length as number of probabilities
for i=1:length(symbols)
    tempbook{i,1} = symbols(i);
end

mEvents = num2cell(1:length(P)); % Changing list for events, merged and single
mProb = P; % Changing list for probabilities, merged and single

% Loop until there is only 1 merged value left
while(length(mEvents) > 1)
    
    % Sort the list of merged/single probabilities
    % and retrieve both a list of probabilites and index values of the
    % events
    [sProb, sInd] = sort(mProb);

    % Get the events with the smallest probabilites from merged list
    % events are in a cell array with all the sub-events in the cell
    smallestE1 = mEvents{sInd(1)};
    smallestE2 = mEvents{sInd(2)};
        
    % Add a 0 to the codeword of the smallest probability
    % and all the sub-probabilities "under" the chosen node
    for i = 1:length(smallestE1)
        tempbook{smallestE1(i), 2} = [0, tempbook{smallestE1(i),2}];
    end
    
    % Add a 1 to the codeword of the second smallest probability
    % and all the sub-probabilities "under" the chosen node    
    for i = 1:length(smallestE2)
        tempbook{smallestE2(i), 2} = [1, tempbook{smallestE2(i),2}];
    end
    
    % Add the events to the merged event cell array, as a cell of
    % both the events to be able to add code to them
    mEvents{end+1} = [smallestE1, smallestE2];
    
    % Add the sum of both the probabilites to the merged probabilities to
    % be able to sort them into the "tree"
    mProb(end+1) = sProb(1)+sProb(2);

    % Remove the single events and probabilities as they now exists as
    % merged cells
    mEvents(sInd(1:2)) = [];   
    mProb(sInd(1:2)) = [];    

end

CodeBook = tempbook;
