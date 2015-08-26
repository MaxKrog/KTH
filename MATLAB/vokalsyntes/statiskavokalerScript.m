vOO  = [    300   600    2350   3250 ]'; %rot
vO   = [    350   700    2600   3200 ]'; %rott 
vAOAO= [    400   700    2450   3250 ]'; %rå
vAO  = [    500   850    2550   3250 ]';%rått
vAA  = [    600   950    2550   3300 ]';%bar
vA   = [    750   1250   2500   3350 ]';%barr
vII  = [    250   2200   3150   3750 ]';%bil
vI   = [    350   2150   2750   3500 ]';%bill
vEE  = [    350   2250   2850   3550 ]';%deg
vE   = [    500   1900   2550   3350 ]';%vägg
vAE  = [    650   1700   2500   3450 ]';%herr
vYY  = [    250   2050   2700   3300 ]';%ny
vY   = [    300   2000   2400   3250 ]';%hytt
vOEOE= [    400   1750   2300   3350 ]';%föd
vOE  = [    550   1550   2450   3300 ]';%född
vOE3 = [    550   1150   2450   3250 ]';%för
vUU  = [    300   1650   2250   2250 ]';%duk

[x,Fs] = audioread('source.wav');

f = [ vYY(1)/Fs , vYY(2)/Fs ,vYY(3)/Fs,vYY(4)/Fs];
bandbredd = [ 50/Fs , 75/Fs, 100/Fs,150/Fs ];

utLjud = statiskavokaler(f(1),bandbredd(1),x)+ statiskavokaler(f(2),bandbredd(2),x)+statiskavokaler(f(3),bandbredd(3),x) + statiskavokaler(f(4),bandbredd(4),x);
utLjud = utLjud/max(utLjud);

sound(utLjud,Fs);
