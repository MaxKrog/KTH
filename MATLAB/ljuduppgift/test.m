
[g,fs] = audioread('ballong.wav');

 delay=2*fs;
delayedsignal=zeros(length(g),2);
for n=1:1:length(g)
    if(n<=delay )
        delayedsignal(n,1)=0;
        delayedsignal(n,2)=0;
    end
    if(n>delay)
        delayedsignal(n,1)=0.65*g(n-delay,1);
        delayedsignal(n,2)=0.65*g(n-delay,2);
    end
end

echosignal=zeros(length(g),2);
for n=1:1:length(g)
    echosignal(n,1)=(g(n,1)+delayedsignal(n,1))*0.5;
    echosignal(n,2)=(g(n,2)+delayedsignal(n,2))*0.5;
end
sound(echosignal,44100);
%audiowrite('echo_constant.wav',delayedsignal,44100);