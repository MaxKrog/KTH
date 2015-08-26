clear all
close all

kubSida = 2.5;
kubVolym = kubSida*kubSida*kubSida;
kubYta = kubSida*kubSida*6;
absMedel = 0.02;

efterklangsTid = 0.161*kubVolym/(kubYta*absMedel);

cLjud = 343.4;
nEkon = (cLjud* efterklangsTid)/(kubSida*1.5);
%nEkon = 10;
koeff = 1/nEkon;
nEkon = round(nEkon);

[song,Fs] = audioread('klapp.wav');
Fefterklang = round(Fs * efterklangsTid);
ekoIntervall = round(Fefterklang / nEkon);

out = zeros(round(Fs*efterklangsTid+Fs),1); 

%for a = 1:1:length(song)
 %   out(a,1) = song(a,1);
  %  out(a,2) = song(a,2);
%end
for n = 1: 1 : length(song)
    for i = 0:1:nEkon
        out(n + i*ekoIntervall,1) = ( out(n + i*ekoIntervall,1) + (1/6)*song(n,1) )*(1-koeff*i);

    end
end

tooHigh = max(out);
if (tooHigh > 2)
    out = out(:,1)/max(out);
end




audiowrite('klappreverb.wav',out,Fs);

