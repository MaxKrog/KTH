vOO  = [    300   600    2350   3250 ]'; %rot
vO   = [    350   700    2600   3200 ]'; %rott 
vAOAO= [    400   700    2450   3250 ]'; %r�
vAO  = [    500   850    2550   3250 ]';%r�tt
vAA  = [    600   950    2550   3300 ]';%bar
vA   = [    750   1250   2500   3350 ]';%barr
vII  = [    250   2200   3150   3750 ]';%bil
vI   = [    350   2150   2750   3500 ]';%bill
vEE  = [    350   2250   2850   3550 ]';%deg
vE   = [    500   1900   2550   3350 ]';%v�gg
vAE  = [    650   1700   2500   3450 ]';%herr
vYY  = [    250   2050   2700   3300 ]';%ny
vY   = [    300   2000   2400   3250 ]';%hytt
vOEOE= [    400   1750   2300   3350 ]';%f�d
vOE  = [    550   1550   2450   3300 ]';%f�dd
vOE3 = [    550   1150   2450   3250 ]';%f�r
vUU  = [    300   1650   2250   2250 ]';%duk

[N,Fs] = audioread('source.wav');

F1 = linspace(vAA(1), vUU(1) ,length(N))'/Fs;
F2 = linspace(vAA(2), vUU(2) ,length(N))'/Fs;
F3 = linspace(vAA(3), vUU(3) ,length(N))'/Fs;
F4 = linspace(vAA(4), vUU(4) ,length(N))'/Fs;


utLjud = formantfilter(F1,50/Fs,N) + formantfilter(F2,75/Fs,N) + formantfilter(F3,100/Fs,N) + formantfilter(F4,150/Fs,N);
utLjud= utLjud/max(utLjud);

sound(utLjud,Fs);
