[source,Fs] = audioread('lydia9.wav'); %Filen som ska processeras

MIC = [5 , 1 , 1];  %Micens position (som en vektor)
n = 9;              %Hur m�nga virtuella ljud-k�llor ska functionen r�kna med?
RM = [ 10,10,10];   %Rummets dimensioner (som en vektor)
SRC = [5,1,9];      %Ljudk�llans position (som en vektor)


output=[0 0];           %Tom start-matris f�r att sedan kunna l�gga p� de andra simuleringarna vertikalt.
for i=0:1:5
    r = i*0.2;          %Denna rundas reflektionsfaktor (1-absorptionsfaktor)
    
    reverbat = rir(Fs,MIC,n,r,RM,SRC); %Filtret (Eller?)
    
    left = conv(reverbat, source(:,1));     %V�nsta kanalen faltad med (filtret)
    left = left/max(left);                   %V�nsta kanalen normaliserad
    
    right = conv(reverbat, source(:,2));    %H�gra kanalen faltad med (filtret)
    right = right/max(right);              %H�gra kanalen normaliserad
    segmentStereo = [left right];           %Sammans�ttning
   
    output = vertcat(output,segmentStereo);
end

audiowrite('processerat.wav',output,Fs);         %Skriver filen till disk
%sound(output,Fs);



cd 