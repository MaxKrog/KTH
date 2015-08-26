[Beat, Fs] = audioread('beat.wav'); %Ursprungs-ljudet 
Beat = Beat(:,1); %Detta exempel anv�nder sig av mono-ljud.

%H�mtar kub-sidan fr�n anv�ndaren.
kubSida = input('Vad ska kuben du spelar upp ljudet i ha f�r sidl�ngd (m) ? 3 till 8 rekommenderas: ');
kubArea = kubSida*kubSida*6;
kubVolym = kubSida.^3;

%H�mtar medelabsorptions-v�rdet fr�n anv�ndaren.
medelAbsorption = input('Vad ska ditt rum ha f�r medelabsorptionsv�rde? Mellan 0.2 till 1.0 rekommenderas: ');

efterklangsTid = 0.161*(kubVolym / (medelAbsorption*kubArea)); %Efterklangstid i Sekunder. (Sabines formel)
disp(['Efterklangstiden ber�knades till ' , num2str(efterklangsTid) , ' sekunder']);
disp('Det simulerade ljudet spelas nu.');
tid = [];
index = 0;
while true %Loopen r�knar ut varje impuls delay. Alla v�rden �r allts� fr�n starttiden 0 s.
    tid = vertcat(tid, log(1+index)*0.2+kubSida/50); %avst�ndet fr�n originalljudet till eko(n+1)
    index = index +1;
    
    if max(tid) > efterklangsTid %Simulerar en do-while loop.
        break;
    end
end

avtagning = db2mag(linspace(60,0,length(tid)+1))'; %Skapar en vektor som g�r fr�n 60db till 0 db i lika m�nga steg som det blir impulser. Omvandlar sedan detta till amplitud.
avtagning = avtagning./max(avtagning); %Normaliserar vektorn.

output = zeros(round(max(tid)*Fs)+length(Beat),1); %Plats-h�llare f�r utljudet.
output(1:length(Beat),1) = Beat; %S�tter in ursprungs-ljudet i vektorn utan att mixtra med dess egenskaper.

sigma = 7;
size = 20;
x = linspace(-size / 2, size / 2, size)';
gaussFilter = exp(-x .^ 2 / (2 * sigma ^ 2)); %Skapar ett gauss-filter. Har utg�tt ifr�n vad jag tycker l�ter bra.
gaussFilter = gaussFilter / sum (gaussFilter); % Normalisera filtret. (Viktigt att det summerar till 1.)

for c = 1:length(tid)
     start = round(tid(c)*Fs); %Vart startar denna impuls?
     slut = start + length(Beat)-1; %Vart slutar denna impuls?
     eko = avtagning(c+1,1)*Beat; %Ta ursprungsljudet och multiplicera med amplitud-koefficient f�r den impulsen.
     
     output(start:slut,1) = output(start:slut,1) + conv( eko,gaussFilter,'same'); %L�gg till impulsen (l�gpassfiltrerad).
end

subplot(2,1,1)
plot(Beat)
subplot(2,1,2)
plot(output)
sound(output,Fs); %L�t det ljuda!