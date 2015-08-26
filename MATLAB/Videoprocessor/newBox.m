vid = VideoReader('dessert320.mp4');
nFrames = vid.frameRate*2; %Hur m�nga sekunders frames ska l�sas in?
vidFrames = read(vid,[1 nFrames]);
vidHeight = vid.Height; %F�r att spara width/height i workspacet.
vidWidth = vid.Width;

pic = imread('newyork.jpg');
pic = imresize(pic,[vidHeight vidWidth]);


for n=1:nFramesf
    frame = vidFrames(:,:,:,n)/255;
    greenness = frame(:,:,2).*(frame(:,:,2)-frame(:,:,1)).*(frame(:,:,2)-frame(:,:,3)); %Formel som s�tter ett v�rde p� varje pixel.
    thresh = 0.3*mean(greenness(greenness>0)); %Treshhold f�r "gr�n" pixel
    isgreen = greenness > thresh; %Skapar en logiskt matris med de gr�na pixlarna som ettor.
    
%     outline = edge(isgreen,'roberts');
%     se = strel('disk',1);
%     outline = imdilate(outline,se); %G�r kanterna n�got st�rre.
%     
%     isgreen = isgreen | outline; % Om 1:a i n�gon av matriserna -> spara etta. Annars nolla. "Summerar" logiska matriser.
%     
    %blurfactor = round(n/10) +1; 
    for j=1:3 %Loopar �ver varje f�rgmatris.
        vidReplace = vidFrames(:,:,j,n);
        picReplace = pic(:,:,j);
        vidReplace(isgreen) =picReplace(isgreen);

        %vidReplace = gaussblur(vidReplace,blurfactor);
        vidFrames(:,:,j,n) = vidReplace;
    end
    
end

% 
% saveVid = VideoWriter('output.avi');
% open(saveVid);
% for k=1:nFrames
%     writeVideo(saveVid,vidFrames(:,:,:,k));
% end
% close(saveVid);