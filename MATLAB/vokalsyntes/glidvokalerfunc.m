function Y = glidvokalerfunc(startF,slutF,Fs)

source = simplesource(linspace(85,180,Fs)'/Fs);
FMatris = vertcat(startF,slutF);

F1 = linspace(FMatris(1,1), FMatris(2,1) ,Fs)'/Fs;
F2 = linspace(FMatris(1,2), FMatris(2,2) ,Fs)'/Fs;
F3 = linspace(FMatris(1,3), FMatris(2,3) ,Fs)'/Fs;
F4 = linspace(FMatris(1,4), FMatris(2,4) ,Fs)'/Fs;


utLjud = formantfilter(F1,50/Fs,source) + formantfilter(F2,75/Fs,source) + formantfilter(F3,100/Fs,source) + formantfilter(F4,150/Fs,source);
Y = utLjud/max(utLjud);