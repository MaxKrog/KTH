vid = VideoReader('dessert320.mp4');
framesToRead = vid.frameRate*1;
vidFrames = read(vid,[1 framesToRead]);
vidHeight = vid.Height; %För att spara width/height i workspacet.
vidWidth = vid.Width;

pic = imread('peder.jpg');
pic = imresize(pic,[vidHeight vidWidth]);



for frame =1 : 1 %framesToRead
    greenness = vidFrames(:,:,2,frame).*(vidFrames(:,:,2,frame)-vidFrames(:,:,1,frame)).*(vidFrames(:,:,2,frame)-vidFrames(:,:,3,frame));
%     for x = 1: vidHeight
%         for y=1:vidWidth
%             if vidFrames(x,y,2,frame) > 200
%                    vidFrames(x,y,:,frame) = pic(round(x+frame),y,:);
%             end
%         end
%     end
end
