%ecg11 contains time, ecg unfiltered, ecg filtered

%peaks are all greater than 0.4 so if we just store the time/data pairs
%where the data is above 0.4 we can find the peaks then collect samples 80
%before the peak 170 after the peak then plot those on top of each other

%matlab is amazing
close all
[pks,locs] = findpeaks(ecg11(:,3),ecg11(:,1),'MinPeakProminence',0.45,'MinPeakDistance',0.4,'Annotate','extents');
segments = zeros(length(pks),250);
emeandist = zeros(length(pks),1);
% 
% for i = 1:length(pks)
%     j = find(ecg11(:,1) == locs(i));
%     k = j - 80;
%     segments(i, :) = ecg11(k:k+249,3);
%     %vertical shift correction (subtract)
%     segments(i, :) = segments(i, :) - mean(segments(i, :));
%     %plot(ecg11(1:250,1), ecg11(k:k+249,3))
%     %plot(ecg11(1:250,1), segments(i,:))
%     %hold on;
% end
%A=zeros(13,40);
for i = 1:length(pks)
    j = find(ecg11(:,1) == locs(i));
    k = j - 80;
    if (k+249 > length(ecg11(:,1)))
        break;
    elseif (k < 1)
        k = 1;
    end
    segments(i, :) = ecg11(k:k+249,3);
    segments(i, :) = segments(i, :)- mean(segments(i, :));
    
    data=(segments(i,:)).';
    waveletName = 'db3';
    waveletLevel = 3;
    dwtmode('ppd');
    [C,L] = wavedec(data,waveletLevel,waveletName);
    B(i,:)=C(1:23);
    %plot(ecg11(1:250,1), ecg11(k:k+249,3))
    %plot(ecg11(1:250,1), segments(i,:))
    %hold on;
end

 %% eucledian mean distance, gives us 13 values
% % look at the top 6 and take them for QT correction next
% %figure
% %plot(ecg11(1:250,1), mean(segments))
% for l = 1:length(pks)
%      emeandist(l) = norm(mean(segments) - segments(l,:));
% end

% %% wavelet
% 
% data = (segments).'; %column vector of mean values
% waveletName = 'db3';
% waveletLevel = 3;
% dwtmode('ppd');
% [C,L] = wavedec(data,waveletLevel,waveletName);
% figure;
% subplot(2,1,1);  plot(data);axis tight
% subplot(2,1,2);  stem(C);axis tight
% 
% A=C(1:35);
% figure
% plot(A)
%% pca
[coeff,~,~,~,explained]=pca(B)
