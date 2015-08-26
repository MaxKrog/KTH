function [ error ] = meanSquaredError( before, after )
%MEANSQUAREDERROR Calculates mean squared error between to matrixes.
% In: before = matrix before. After = matrix after.
% Out : error : value of MSE

before = double(before); %Needed to not clip data when counting.
after = double(after);

errorMatrix = (before - after).^2;
error = mean(mean(errorMatrix));

end

