[Beat, Fs] = audioread('beat.wav'); %Ursprungs-ljudet 
Beat = Beat(:,1); %Detta exempel använder sig av mono-ljud.

%Hämtar kub-sidan från användaren.
kubSida = input('Vad ska kuben du spelar upp ljudet i ha för sidlängd (m) ? 3 till 8 rekommenderas: ');
kubArea = kubSida*kubSida*6;
kubVolym = kubSida.^3;

%Hämtar medelabsorptions-värdet från användaren.
medelAbsorption = input('Vad ska ditt rum ha för medelabsorptionsvärde? Mellan 0.2 till 1.0 rekommenderas: ');

efterklangsTid = 0.161*(kubVolym / (medelAbsorption*kubArea)); %Efterklangstid i Sekunder. (Sabines formel)
disp(['Efterklangstiden beräknades till ' , num2str(efterklangsTid) , ' sekunder']);
disp('Det simulerade ljudet spelas nu.');
tid = [];
index = 0;
while true %Loopen räknar ut varje impuls delay. Alla värden är alltså från starttiden 0 s.
    tid = vertcat(tid, log(1+index)*0.2+kubSida/50); %avståndet från originalljudet till eko(n+1)
    index = index +1;
    
    if max(tid) > efterklangsTid %Simulerar en do-while loop.
        break;
    end
end

avtagning = db2mag(linspace(60,0,length(tid)+1))'; %Skapar en vektor som går från 60db till 0 db i lika många steg som det blir impulser. Omvandlar sedan detta till amplitud.
avtagning = avtagning./max(avtagning); %Normaliserar vektorn.

output = zeros(round(max(tid)*Fs)+length(Beat),1); %Plats-hållare för utljudet.
output(1:length(Beat),1) = Beat; %Sätter in ursprungs-ljudet i vektorn utan att mixtra med dess egenskaper.

sigma = 7;
size = 20;
x = linspace(-size / 2, size / 2, size)';
gaussFilter = exp(-x .^ 2 / (2 * sigma ^ 2)); %Skapar ett gauss-filter. Har utgått ifrån vad jag tycker låter bra.
gaussFilter = gaussFilter / sum (gaussFilter); % Normalisera filtret. (Viktigt att det summerar till 1.)

for c = 1:length(tid)
     start = round(tid(c)*Fs); %Vart startar denna impuls?
     slut = start + length(Beat)-1; %Vart slutar denna impuls?
     eko = avtagning(c+1,1)*Beat; %Ta ursprungsljudet och multiplicera med amplitud-koefficient för den impulsen.
     
     output(start:slut,1) = output(start:slut,1) + conv( eko,gaussFilter,'same'); %Lägg till impulsen (lågpassfiltrerad).
end

subplot(2,1,1)
plot(Beat)
subplot(2,1,2)
plot(output)
sound(output,Fs); %Låt det ljuda!