%load mean segments
[a1, t1, seg1] = ecgfp(ecg1);
[a2, t2, seg2] = ecgfp(ecg2);
[a3, t3, seg3] = ecgfp(ecg3);
[b1, t4, seg4] = ecgfp(ecg4);
[c1, t5, seg5] = ecgfp(ecg5);
[d1, t6, seg6] = ecgfp(ecg6);

%training set
training = zeros(4,250);
training(1, 1:250) = a1;
training(1, 1:250) = a2;
training(1, 1:250) = b1;
training(1, 1:250) = c1;

%label set
lbl = {'p1', 'p1', 'np1', 'np2'};

%creates the linear discriminant classifier
ldc = fitcdiscr(training, lbl);

%test other data
predict(ldc,a3)
predict(ldc,d1)

