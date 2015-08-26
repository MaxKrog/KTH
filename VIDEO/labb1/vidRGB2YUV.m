function vidRGB2YUV( filePath )
%%
% This function convers a color video file to black and white.
% Input: 
% filePath: the full path that RGB video file is stored 
% --
% Output:
% void

[path,name,ext] = fileparts(filePath);
outputPath = strcat(path,'/Show.avi');

disp(filePath);
disp(outputPath);

%% complicated... pretend you didn't see below (don't modify)
vidObj = VideoReader(filePath);
writerObj = VideoWriter(outputPath, 'Grayscale AVI');
open(writerObj);
% pretend you didn't see above

%% extracting frames
try % try/catch makes sure uncompleted code works with GUI, you can ignore try/catch here
    % complete the for loop below 
    while hasFrame(vidObj)  % how many frames do you want to process? Consider a small value in the beginning
        % process frames in each iteration
        frame =  readFrame(vidObj); %Reads the next frame
        YUVframe = frameRGB2YUV( frame );   
        writeVideo(writerObj, YUVframe(:,:,1)); % replace something_composes_the_BW_frames with sth. else, try to use 'help' for more information
    end

catch
    disp('Error in vidRGB2YUV.m');
end

close(writerObj);

end

