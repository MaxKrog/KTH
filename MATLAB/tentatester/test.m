%% Moving-average-filter
X = rand(30,1)
A = [0.2 0.2 0.2 0.2 0.2]
Y = filter(A,1,X)
plot(1:30,X,'r', 1:30,Y,'g')