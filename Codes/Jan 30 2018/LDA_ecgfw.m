%load mean segments

ecg1_1=csvread('data/ecg1_1.csv',2,0);
ecg1_2=csvread('data/ecg1_2.csv',2,0);
ecg1_3=csvread('data/ecg1_3.csv',2,0);
ecg1_4=csvread('data/ecg1_8.csv',2,0);

ecg2_1=csvread('data/ecg2_1.csv',2,0);
ecg3_1=csvread('data/ecg3_1.csv',2,0);
ecg4_1=csvread('data/ecg4_1.csv',2,0);
ecg4_2=csvread('data/ecg13_1.csv',2,0);
ecg5_1=csvread('data/ecg5_1.csv',2,0);



a1 = ecgfw(ecg1_1);
a2 = ecgfw(ecg1_2);
a3 = ecgfw(ecg1_3);
a4 = ecgfw(ecg1_4);

b1= ecgfw(ecg2_1);
c1= ecgfw(ecg3_1);

d1 = ecgfw(ecg4_1);
d2 = ecgfw(ecg4_2);

e1 = ecgfw(ecg5_1);

%training set
training = zeros(7,45);
training(1, 1:45) = a1;
training(2, 1:45) = a2;
training(3, 1:45) = a3;
%training(1, 1:45) = a4;
training(4, 1:45) = b1;
training(5, 1:45) = c1;
training(6, 1:45) = d1;
%training(1, 1:45) = d2;
training(7, 1:45) = e1;

%label set
lbl = {'p1', 'p1','p1', 'np1', 'np1','np1', 'np1'};

%creates the linear discriminant classifier
ldc = fitcdiscr(training, lbl);

%test other data
predict(ldc,a4)
predict(ldc,d2)

