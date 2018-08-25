close all;
input = csvread('Efe-PQRST.lvm');%read the file
x=conv(input,Num); %convolution with a BP filter
%cutoff of 5 and 30 Hz designed using the filterDesign app.
[peaks,location] = findpeaks(x,'MinPeakDistance',1400);%read the max peaks 
plot(x)
time1 = (location(3,1) - location(2,1))/1000 %find the period using the time b/w 3rd and 2nd QRS peaks
time2 =(location(2,1) - location(1,1))/1000 %find the period using the time b/w 2nd and 1st QRS peaks
HR_pmin = 60/((time1+time2)/2)%calculate heart rate