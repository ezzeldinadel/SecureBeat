function [output,time] = ecgfp(ecg1)
%Take an ecg and return the mean sample

%peaks are all greater than 0.4 so if we just store the time/data pairs
%where the data is above 0.4 we can find the peaks then collect samples 80
%before the peak 170 after the peak then plot those on top of each other

%matlab is amazing
[pks,locs] = findpeaks(ecg1(:,3),ecg1(:,1),'MinPeakProminence',0.45,'Annotate','extents');
segments = zeros(length(pks),250);
emeandist = zeros(length(pks),1);

for i = 1:length(pks)
    j = find(ecg1(:,1) == locs(i));
    k = j - 80;
    
    if (k < 1)
        k = 1;
    elseif (k+249 > length(ecg1(:,1)))
        break;
    end
    
    segments(i, :) = ecg1(k:k+249,3);
    segments(i, :) = segments(i, :) - mean(segments(i, :));
    %plot(ecg1(1:250,1), ecg1(k:k+249,3))
    %plot(ecg1(1:250,1), segments(i,:))
    %hold on;
end

%plot(ecg1(1:250,1), mean(segments))
for l = 1:length(pks)
     emeandist(l) = norm(mean(segments) - segments(l,:));
end

%Sort for 6 closes signals

%https://www.thecalculator.co/health/QTc-Calculator-385.html link for
%information on QT correction which is the final step to preparing the data
%set for analysis techniques

output = mean(segments);
time = ecg1(1:250,1);

end

